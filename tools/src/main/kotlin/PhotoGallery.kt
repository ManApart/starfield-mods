@file:Suppress("UNCHECKED_CAST")

import utils.readConfig
import java.io.File

private const val dryRun = false

fun main() {
    val config = readConfig()["starfield"] as Map<String, String>

    val gallery = File(config["galleryPath"]!!)
    val destination = File(config["galleryDestination"]!!)
    rename(gallery, destination)
}

private fun rename(folder: File, destination: File) {
    println("Procsessing ${folder.absolutePath}")
    folder.listFiles()!!
        .filter { it.extension == "png" && !it.name.contains("thumbnail") }
        .also { println("Found ${it.size} matching files.") }
        .forEach {
            if (dryRun) {
                println(File(destination.absolutePath + "/" + it.name))
            } else {
                try {
                    it.copyTo(File(destination.absolutePath + "/" + it.name.replace("'", "")))
                } catch (_: FileAlreadyExistsException) {
                }
            }
        }
}
