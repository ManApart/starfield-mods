import com.fasterxml.jackson.module.kotlin.readValue
import utils.mapper
import java.io.File
import java.nio.ByteBuffer
import java.nio.ByteOrder

data class Entry(val id: UInt, var text: String)

// Warning, heavily generated
fun main() {
    val replacementFile = File("input/replacer.json")
    val originalFile = File("input/original.json")
    val replacements = mapper.readValue<Map<String, String>>(replacementFile.readText())
    val originals = mapper.readValue<Map<String, String>>(originalFile.readText())
    val replacementsByText = linkedMapOf<String, String>()

    for ((key, newText) in replacements) {
        val oldText = requireNotNull(originals[key]) {
            "No original text for key $key in ${originalFile.path}"
        }
        require('\u0000' !in newText) { "Replacement for key $key contains a NUL character" }
        val previous = replacementsByText.put(oldText, newText)
        require(previous == null || previous == newText) {
            "Conflicting replacements for original text at key $key: $oldText"
        }
    }

    val filePairs = listOf(
        Pair(File("input/replacer/starfield_en.strings"), File("out/replacer/starfield_en.strings")),
        Pair(File("input/replacer/starfield_en.dlstrings"), File("out/replacer/starfield_en.dlstrings")),
        Pair(File("input/replacer/starfield_en.ilstrings"), File("out/replacer/starfield_en.ilstrings")),
    )

    val matchedTexts = mutableSetOf<String>()
    var total = 0
    filePairs.forEach { (file, out) ->
        val lengthPrefixed = file.extension.lowercase() != "strings"
        val entries = readStringEntries(file.readBytes(), lengthPrefixed)
        var count = 0
        for (entry in entries) {
            val newText = replacementsByText[entry.text] ?: continue
            matchedTexts += entry.text
            if (entry.text != newText) {
                entry.text = newText
                count++
            }
        }
        if (count > 0) {
            out.writeBytes(writeStringEntries(entries, lengthPrefixed))
        }
        total += count
        println("${file.path}: replaced $count string(s).")
    }

    println("Replaced $total strings")
}

fun readStringEntries(bytes: ByteArray, lengthPrefixed: Boolean): MutableList<Entry> {
    require(bytes.size >= 8) { "Strings file is too short to contain a header" }
    val buffer = ByteBuffer.wrap(bytes).order(ByteOrder.LITTLE_ENDIAN)

    val count = buffer.int
    val dataSize = buffer.int

    val directoryStart = 8
    val dataStartLong = directoryStart.toLong() + count.toLong() * 8
    require(count >= 0 && dataSize >= 0 && dataStartLong + dataSize <= bytes.size) {
        "Strings header reports invalid directory or data size"
    }
    val dataStart = dataStartLong.toInt()
    val dataEnd = dataStart + dataSize

    val entries = mutableListOf<Entry>()

    repeat(count) { i ->
        val entryPos = directoryStart + i * 8

        val id = ByteBuffer.wrap(bytes, entryPos, 4)
            .order(ByteOrder.LITTLE_ENDIAN)
            .int
            .toUInt()

        val relativeOffset = ByteBuffer.wrap(bytes, entryPos + 4, 4)
            .order(ByteOrder.LITTLE_ENDIAN)
            .int

        require(relativeOffset >= 0 && relativeOffset < dataSize) {
            "Invalid offset for string ID 0x${id.toString(16)}"
        }
        val stringPos = dataStart + relativeOffset
        val textStart: Int
        val terminatorPos: Int

        if (lengthPrefixed) {
            require(stringPos.toLong() + 4 <= dataEnd) {
                "Missing length for string ID 0x${id.toString(16)}"
            }
            val length = ByteBuffer.wrap(bytes, stringPos, 4)
                .order(ByteOrder.LITTLE_ENDIAN)
                .int
            require(length >= 1 && stringPos.toLong() + 4 + length <= dataEnd) {
                "Invalid length for string ID 0x${id.toString(16)}"
            }
            textStart = stringPos + 4
            terminatorPos = textStart + length - 1
        } else {
            textStart = stringPos
            var end = textStart
            while (end < dataEnd && bytes[end] != 0.toByte()) end++
            require(end < dataEnd) {
                "Missing NUL terminator for string ID 0x${id.toString(16)}"
            }
            terminatorPos = end
        }

        require(bytes[terminatorPos] == 0.toByte()) {
            "Missing NUL terminator for string ID 0x${id.toString(16)}"
        }

        val textBytes = bytes.copyOfRange(
            textStart,
            terminatorPos
        )

        entries += Entry(
            id = id,
            text = textBytes.toString(Charsets.UTF_8)
        )
    }

    return entries
}

fun writeStringEntries(entries: List<Entry>, lengthPrefixed: Boolean): ByteArray {
    data class EncodedEntry(val id: UInt, val block: ByteArray)

    val encoded = entries.map { entry ->
        val textBytes = entry.text.toByteArray(Charsets.UTF_8)

        val block = ByteBuffer
            .allocate((if (lengthPrefixed) 4 else 0) + textBytes.size + 1)
            .order(ByteOrder.LITTLE_ENDIAN)
            .apply {
                // DLSTRINGS and ILSTRINGS lengths include the trailing NUL.
                if (lengthPrefixed) putInt(textBytes.size + 1)
                put(textBytes)
                put(0)
            }
            .array()

        EncodedEntry(entry.id, block)
    }

    val count = encoded.size
    val dataSize = encoded.sumOf { it.block.size }

    val output = ByteBuffer
        .allocate(8 + count * 8 + dataSize)
        .order(ByteOrder.LITTLE_ENDIAN)

    output.putInt(count)
    output.putInt(dataSize)

    var dataOffset = 0

    for (entry in encoded) {
        output.putInt(entry.id.toInt())
        output.putInt(dataOffset)

        dataOffset += entry.block.size
    }

    for (entry in encoded) {
        output.put(entry.block)
    }

    return output.array()
}
