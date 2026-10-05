import com.fasterxml.jackson.module.kotlin.readValue
import utils.mapper
import utils.readConfig
import utils.oggToWem
import utils.wavToOgg
import java.io.File
import kotlin.collections.joinToString

data class LineScript(val text: String, val promptVoice: File, val outWav: File, val outOgg: File, val outWem: File)

fun main() {
    val config = readConfig()
    val tts =config["tts"] as Map<String, String>
    val dir = File(tts["directory"])
    val wem = File(tts["wav2wem"])
    val lineMap = File("input/replacer.json").readText().let { mapper.readValue<Map<String, String>>(it) }
    val defaultVoice = File("input/replacer").listFiles()!!.first()
    val scripts = lineMap.entries.map { (id, text) ->
        val voice = File("input/replacer/$id.wav").takeIf { it.exists() } ?: defaultVoice
        val outPut = File("out/replacer/$id.wav")
        val outWem = File("out/replacer/$id.wem")
        val outOgg = File("out/replacer/$id.ogg")
        LineScript(text, voice, outPut, outOgg, outWem)
    }

    scripts.filter { !it.outWav.exists() }.also { println("Processing ${it.size} scripts") }.chunked(30)
        .forEach { processBatch(dir, it, true) }

    scripts.filter { it.outWav.exists() && !it.outOgg.exists() }.forEach { it.outWav.wavToOgg(it.outOgg) }
    scripts.filter { it.outOgg.exists() && !it.outWem.exists() }.forEach { it.outOgg.oggToWem(wem) }
}


fun processBatch(directory: File, scripts: List<LineScript>, verbose: Boolean = false) {
    val pyCode = """
import torchaudio as ta
import torch
from chatterbox.tts import ChatterboxTTS
device = "cuda"

model = ChatterboxTTS.from_pretrained(device=device)
${
        scripts.joinToString("\n") { script ->
            """
wav = model.generate("${script.text}", audio_prompt_path="${script.promptVoice.absolutePath}")
ta.save("${script.outWav.absolutePath}", wav, model.sr)
"""
        }
    }
    """
    File("${directory.absolutePath}/inference.py").writeText(pyCode)
    val result = directory.runCommand("env/bin/python inference.py")
    if (verbose) println(result)
}
