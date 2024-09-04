import utils.readConfig
import utils.wemToWavVgm
import java.io.File
import java.nio.file.Files
import kotlin.io.path.Path

fun main() {
    val rawConfig = readConfig()
    val audioConfig = rawConfig["audioTools"] as Map<String, Any>
    val starfieldConfig = rawConfig["starfield"] as Map<String, Any>
    val input = starfieldConfig["ostExport"] as String
    val output = starfieldConfig["ostExportDest"] as String
    val tool = File(audioConfig["tool"] as String)

    File(input).listFiles().forEach { folder ->
        println("\nProcessing ${folder.name}")
        processDirectory(folder, output, tool)
    }
}

private fun processDirectory(folder: File, output: String, tool: File) {
    folder.listFiles().filter { it.isDirectory }.forEach { processDirectory(it, output +"/${it.name}", tool) }
    folder.listFiles().filter { !it.isDirectory }.forEach {
        val cleanName = if (it.nameWithoutExtension.contains("_")) it.nameWithoutExtension.substring(0, it.nameWithoutExtension.lastIndexOf("_")) else it.nameWithoutExtension

        val voiceFile = File("${output}/${folder.nameWithoutExtension}/${cleanName}.mp3")
        if (!voiceFile.exists()) {
            println(cleanName)
            try {

                it.wemToWavVgm(tool)
                it.parentFile.runCommand(listOf("ffmpeg", "-i", "${it.nameWithoutExtension}.wav", "temp.mp3"))
                voiceFile.parentFile.mkdirs()
                Files.move(Path("${it.parentFile.absolutePath}/temp.mp3"), voiceFile.toPath())
                File(it.parentFile.absolutePath + "/${it.nameWithoutExtension}.wav").delete()
            } catch (e: Exception) {
                println("Failed to process ${it.name}")
            }
        }
    }
}
