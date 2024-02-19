import utils.combineAudio
import utils.getSilences
import utils.readConfig
import utils.trimAudio
import java.io.File
import java.nio.file.Files
import java.nio.file.StandardCopyOption
import java.text.SimpleDateFormat
import java.util.*

fun main() {
    val config = readConfig()
    val ttsConfig = config["tts"] as Map<String, String>
    val sayMyNameConfig = config["sayMyName"] as Map<String, Any>
    val coquiDir = File(ttsConfig["directory"]!!)
    val stagingDir = File(sayMyNameConfig["stagingDirectory"] as String)
    val characters = (sayMyNameConfig["characters"] as Map<String, String>).keys
    val exitOnError = sayMyNameConfig["exitOnError"] as Boolean? ?: false
    val skipExisting = sayMyNameConfig["skipExisting"] as Boolean? ?: true
    val batchSize = sayMyNameConfig["batchSize"] as Int? ?: 32
    val onlyCharacter = (sayMyNameConfig["onlyCharacter"] as String?)?.takeIf { it.isNotBlank() }
    val onlyName = (sayMyNameConfig["onlyName"] as String?)?.takeIf { it.isNotBlank() }?.capitalize()
    val onlyLine = (sayMyNameConfig["onlyLine"] as String?)?.takeIf { it.isNotBlank() }

    val playerNames = File("reference/sayMyName/name-groups.txt").readLines()
        .flatMap { it.split(",") }.map { it.trim().capitalize() }.filter { it.isNotBlank() }
        .let { names -> if (onlyName != null) names.filter { it == onlyName } else names }

    characters
        .let { names -> if (onlyCharacter != null) names.filter { it == onlyCharacter } else names }
        .forEach { character ->
            println("Processing $character")
            val workingDir = File(stagingDir.absolutePath + "/$character")
            val tempFile = File(workingDir.absolutePath + "/temp.wav")
            val tempFile2 = File(workingDir.absolutePath + "/temp1.wav")
            val tempFile3 = File(workingDir.absolutePath + "/temp2.wav")
            val lines = File("reference/sayMyName/$character.txt").readLines().toLines()
            val lineOverrideFile = File("input/sayMyName/$character-overrides.txt").also { if (!it.exists()) it.createNewFile() }
            val lineOverrides = lineOverrideFile.readLines().toLineOverrides(lines)
            val stats = SayMyNameStats(lines.size)

            val recipes = playerNames.map { playerName ->
                File(workingDir.absolutePath + "/out/$playerName/").mkdirs()
                File(coquiDir.absolutePath + "/out/$character/$playerName/").mkdirs()
                val overrides = lineOverrides[playerName] ?: mapOf()
                val filteredLines = lines.let { if (onlyLine != null) it.filter { line -> line.id == onlyLine } else it }
                    .filter { !skipExisting || !File("${workingDir.absolutePath}/out/$playerName/${it.id}.wav").exists() }
                val playerStats = SayMyNamePlayerNameStats(playerName, lines.size - filteredLines.size)
                stats.playerStats[playerName] = playerStats
                Recipe(character, playerName, filteredLines, playerStats, overrides)
            }

            recipes.chunkedByLines(batchSize).forEach { batch ->
                val start = System.currentTimeMillis()
                generateLines(batch, coquiDir, workingDir)

                batch.forEach { recipe ->
                    processLines(recipe.lines, coquiDir, character, recipe.playerName, recipe.overrides, lineOverrideFile, tempFile, tempFile2, tempFile3, workingDir, recipe.stats, exitOnError)
                    recipe.stats.print(lines.size)
                }
                val elapsed = System.currentTimeMillis() - start
                println(cyan("Processed Batch") + " ${batch.first().playerName}-${batch.last().playerName} in ${elapsed.formatTime()}")
            }
            stats.print()
        }
}

private fun generateLines(
    recipes: List<Recipe>,
    coquiDir: File,
    workingDir: File
) {
    val names = recipes.filter { it.lines.isNotEmpty() }.joinToString(", ") { it.playerName }
    val currentDate = SimpleDateFormat("dd/M/yyyy hh:mm:ss").format(Date())
    if (names.isNotBlank()) println(cyan(currentDate) + ": Processing lines for $names")
    val scripts = recipes.flatMap { recipe ->
        recipe.lines.map { line ->
            val text = line.text(recipe.playerName, recipe.overrides)
            val outPath = "./out/${recipe.character}/${recipe.playerName}/${line.id}.wav"
            val voicePaths = listOfNotNull(
                workingDir.absolutePath + "/${line.id}.wav",
                File(workingDir.absolutePath + "/${line.id}-2.wav").takeIf { it.exists() }?.absolutePath
            )
            Script(text, outPath, voicePaths)
        }
    }.filter { !File(coquiDir.absolutePath +"/" + it.outPath).exists() }
    try {
        if (scripts.isNotEmpty()) {
            processBatch(coquiDir, scripts)
        }
    } catch (e: Exception) {
        println(red("Failed to generate lines for $names: ${e.message}, ${e.stackTraceToString()}"))
    }
}

private fun processLines(
    filteredLines: List<Line>,
    coquiDir: File,
    character: String,
    playerName: String,
    overrides: Map<String, String>,
    lineOverrideFile: File,
    tempFile: File,
    tempFile2: File,
    tempFile3: File,
    workingDir: File,
    stats: SayMyNamePlayerNameStats,
    exitOnError: Boolean
) {
    filteredLines.forEach { line ->
        try {
            val ttsOut = File(coquiDir.absolutePath + "/out/$character/$playerName/${line.id}.wav")
            Files.copy(ttsOut.toPath(), tempFile.toPath(), StandardCopyOption.REPLACE_EXISTING)

            val silences = getSilences(tempFile)
            val (nameStart, nameEnd) = line.getName(silences)

            if (nameStart >= nameEnd) {
                //First time failing, delete generated line and add to overrides to next gen does just base name
                if (overrides[line.id] == null) {
                    ttsOut.delete()
                    lineOverrideFile.appendText("$playerName,${line.id}\n")
                }
                throw java.lang.IllegalStateException("Could not find proper start and end")
            }

            cleanName(tempFile, tempFile2, nameStart, nameEnd)
            combineFile(line.id, tempFile2, tempFile3)
            val finished = File(workingDir.absolutePath + "/out/$playerName/${line.id}.wav")
            Files.copy(tempFile3.toPath(), finished.toPath(), StandardCopyOption.REPLACE_EXISTING)
            stats.successes += 1
        } catch (e: Exception) {
            println(red("Failed to process $playerName ${line.id}: ${e.message ?: e.stackTraceToString()}"))
            if (exitOnError) throw IllegalStateException("Encountered Error")
        }
        tempFile2.delete()
        tempFile3.delete()
    }
}


private fun cleanName(input: File, outPut: File, start: Double, end: Double) {
    if (start > end) throw IllegalStateException("Start $start should not be after end $end")
    input.trimAudio(outPut, start, end, 44100, 0.5)
}

private fun combineFile(id: String, input: File, outPut: File) {
    input.combineAudio(outPut, id, "$id-2")
}