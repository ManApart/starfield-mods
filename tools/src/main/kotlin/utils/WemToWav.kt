package utils

import runCommand
import java.io.File
import java.nio.file.Files
import java.nio.file.StandardCopyOption
import kotlin.io.path.Path

const val TO_WAV = true
const val USE_VGM = true

fun main() {
    val config = readConfig()["audioTools"] as Map<String, Any>
    val tool = File(config["tool"] as String)
    val wemFolder = File(config["wemFolder"] as String)
    val wemFiles = config["wemFiles"] as List<String>?

    val filesToConvert = wemFiles?.takeIf { it.isNotEmpty() }?.map { File(wemFolder.absolutePath + "/$it.wem") }
        ?: wemFolder.listFiles()!!.toList()

    filesToConvert.forEach {
        when {
            TO_WAV && USE_VGM -> it.wemToWavVgm(tool)
            TO_WAV -> it.wemToWav(tool)
            else -> it.wemToOgg(tool)
        }
    }
}

//Requires a folder with ww2ogg.exe and ReVorb.exe
fun File.wemToWav(ww2oggFolder: File) {
    Files.copy(toPath(), Path(ww2oggFolder.absolutePath + "/temp.wem"), StandardCopyOption.REPLACE_EXISTING)
    ww2oggFolder.runCommand(listOf("wine", "ww2ogg.exe", "temp.wem", "--pcb", "./packed_codebooks_aoTuV_603.bin"))
    ww2oggFolder.runCommand("wine ReVorb.exe temp.ogg temp1.ogg")
    ww2oggFolder.runCommand("sox temp1.ogg temp.wav")
    Files.copy(Path(ww2oggFolder.absolutePath + "/temp.wav"), File("${parentFile.absolutePath}/$nameWithoutExtension.wav").toPath(), StandardCopyOption.REPLACE_EXISTING)
}

fun File.wemToOgg(ww2oggFolder: File) {
    Files.copy(toPath(), Path(ww2oggFolder.absolutePath + "/temp.wem"), StandardCopyOption.REPLACE_EXISTING)
    ww2oggFolder.runCommand(listOf("wine", "ww2ogg.exe", "temp.wem", "--pcb", "./packed_codebooks_aoTuV_603.bin"))
    ww2oggFolder.runCommand("wine ReVorb.exe temp.ogg temp1.ogg")
    Files.copy(Path(ww2oggFolder.absolutePath + "/temp1.ogg"), File("${parentFile.absolutePath}/$nameWithoutExtension.ogg").toPath(), StandardCopyOption.REPLACE_EXISTING)
}

fun File.wemToWavVgm(vgmFolder: File) {
    Files.copy(toPath(), Path(vgmFolder.absolutePath + "/temp.wem"), StandardCopyOption.REPLACE_EXISTING)
    vgmFolder.runCommand("./vgmstream-cli -o temp.wav temp.wem")
    val dest = File("${parentFile.absolutePath}/$nameWithoutExtension.wav").toPath()
    println(dest)
    Files.copy(Path(vgmFolder.absolutePath + "/temp.wav"), dest, StandardCopyOption.REPLACE_EXISTING)
}

fun File.wavToOgg(dest: File){
    parentFile.runCommand("ffmpeg -i $absolutePath ${dest.absolutePath}")
}

fun File.oggToWem(wav2wem: File) {
    parentFile.runCommand("${wav2wem.absolutePath} ${this.absolutePath}")
}
