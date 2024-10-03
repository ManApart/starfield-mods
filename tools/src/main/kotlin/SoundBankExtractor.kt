import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import com.fasterxml.jackson.annotation.JsonProperty
import com.fasterxml.jackson.module.kotlin.readValue
import kotlinx.coroutines.*
import utils.mapper
import utils.readConfig
import java.io.File
import java.nio.file.Files

@JsonIgnoreProperties(ignoreUnknown = true)
private class Wrapper(
    @JsonProperty("SoundBanksInfo") val soundBanksInfo: SoundBankInfo,
)

@JsonIgnoreProperties(ignoreUnknown = true)
private class SoundBankInfo(
    @JsonProperty("StreamedFiles") val streamedFiles: List<StreamedFile> = listOf(),
    @JsonProperty("SoundBanks") val soundBanks: List<SoundBank>
)

@JsonIgnoreProperties(ignoreUnknown = true)
private class SoundBank(
    @JsonProperty("IncludedEvents") val includedEvent: List<IncludedEvent> = listOf()
)

@JsonIgnoreProperties(ignoreUnknown = true)
private class IncludedEvent(
    @JsonProperty("ReferencedStreamedFiles") val streamedFiles: List<StreamedFile> = listOf()
)

@JsonIgnoreProperties(ignoreUnknown = true)
private data class StreamedFile(
    @JsonProperty("Id") val id: String,
    @JsonProperty("ShortName") val shortName: String,
    @JsonProperty("Path") val path: String
)

private const val LIMIT = 30000
private const val CHUNK_SIZE = 100

fun main() {
    @Suppress("UNCHECKED_CAST")
    val config = readConfig()["starfield"] as Map<String, String>

    val gallery = File(config["vanillaSoundFolder"]!!)
    val destination = File(config["soundBankConverted"]!!)
    moveFiles(gallery, destination)
}

private fun moveFiles(source: File, destination: File) {
    val sounds = parseFileInfo(source)
    println("Parsed ${sounds.size} files")

    var processed = 0
    runBlocking {
        sounds.take(LIMIT).chunked(CHUNK_SIZE).forEach { chunk ->
            chunk.map { sound ->
                async(Dispatchers.IO) {
                    val source = File("${source.absolutePath}/soundbanks/${sound.id}.wem")
                    val target = File(destination.absolutePath + "/" + sound.path.replace(".wem", "").replace("\\", "/") + "-${sound.id}.wem")
                        .also { it.parentFile.mkdirs() }
//                        println("$source\n\t$target")
                    if (!source.exists()) {
                        println("Skipping ${sound.shortName}; source missing")
                    } else if (!target.exists()) {
                        Files.copy(source.toPath(), target.toPath())
                    }
                }
            }.awaitAll()
            processed += chunk.size
            println("Processed $processed/${sounds.size}")
        }
    }
}

private fun parseFileInfo(source: File): List<StreamedFile> {
    val infoFile = File("${source.absolutePath}/soundbanks/soundbanksinfo.json")
    val wrapper: Wrapper = mapper.readValue(infoFile)
    val allFiles = wrapper.soundBanksInfo.streamedFiles + wrapper.soundBanksInfo.soundBanks.flatMap { bank -> bank.includedEvent.flatMap { it.streamedFiles } }
    return allFiles.groupBy { it.path }.values.map { it.first() }
}
