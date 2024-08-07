import utils.readConfig
import utils.wemToWavVgm
import java.io.File
import java.nio.file.Files
import kotlin.io.path.Path

fun main() {
    val rawConfig = readConfig()
    val audioConfig = rawConfig["audioTools"] as Map<String, Any>
    val tts = rawConfig["tts"] as Map<String, Any>
    val starfieldConfig = rawConfig["starfield"] as Map<String, Any>
    val dir = starfieldConfig["wemSourceDirectory"] as String
    val voicesPath = (tts["directory"] as String) + "/voices"
    val tool = File(audioConfig["tool"] as String)

    File(dir).listFiles().filter { it.isDirectory && (it.name.contains("npcm") || it.name.contains("npcf")) }.mapNotNull { folder ->
        folder.listFiles()?.filter { it.name.endsWith("wem") }?.maxByOrNull { it.length() }
    }.forEach {
        val voiceName = it.parentFile.name.replace("npcf", "").replace("npcm", "")
        val sex = if(it.parentFile.name.contains("npcf")) "female" else "male"
        val voiceFile = File("$voicesPath/$sex/${voiceName}.wav")
        if (!voiceFile.exists()) {
            println(it.parentFile.name)
            it.wemToWavVgm(tool)
            Files.copy(Path("$tool/temp.wav"), voiceFile.toPath())
        }
    }
}
