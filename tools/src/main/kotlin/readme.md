# Starfield


## Sound Prepper

This takes in a directory of music for starfield, and its exported wems. It renames the input music files to match wems in the same folder.

SoundKeyMatchers is a map of folder to made up sub folder, in the case that a game folder has a number of groups of songs that you'd like to address separately. In the example below, in my staging folder under the City folder I have `City_A` where I put music specific to that first city. Songs in `City_A` are compared with songs in `City` that contain the string `City_A`. 

DirectKeys should be the name of the custom folder to the list of the wem file without extension. `MUS_Genesis_City_B_02_CC2B72B8-90408194.wem` should be `90408194`

```
"starfield": {
    "soundKeys": [
      "List of folders to look for game wem files",
    ],
    "soundKeyMatchers": {
      "City": [
        "City_A",
      ]
    },
     "directKeys": {
      "Atlantis": [
        "206838369"
      ]
    },
    "soundInput": "The stgaing file to move / rename music from",
  },
```

Cities

Atlantis - D
Cydonia - Dv2 02
Cydonia - B 01


## Say My name

Example Line:
Id, Start, End, Line Contents
```
004b8167,0.6,1.7,for you, {name}.
```
Id: Name of Wem file to generate
Start: As close to right before the name as possible, accounting for variations taking longer or slower
End: As close to right after the name as possible, accounting for variations taking longer or slower
Line Contents: Small phrase that should trigger the name being said naturally

A line can omit either/both start and end. If only one number is given, it's considered the start. Default start and end are 0.0 and 100.
Ex:
```
004b8167,for you, {name}.
004b8167,0.6,for you, {name}.
```

Lines can have additional positions to look for a name in. These additional positions are looked in order of latest position first, and then sooner positions until one is found.
```
004b8167,0.6,1.0,for you, {name}.
004b8167,0.4
```

Tips
- Make generation as small as possible to make trimming more consistent
- Attempt to generate in such a way that silence surrounds the name (commas before, periods after)
- Use colons instead of commas in order to get a good silence between the phrase and the name

Instructions
- Add `input/sayMyName/names.txt` with your list of names to use
- Add `input/sayMyName/andreja.txt` for each character, with the csv for each line
- For each line, add the original line's wav to your staging/character folder
  - Split the line into the prefix and suffix (everything but the name). 
  - Name the prefix the id.wav and the suffix id-2.wav
- Update config with tts.directory where `coqui-tts` is installed (follow tts setup, tts.voice is not needed since you'll use characters)
- Update config with `sayMyName.stagingDirectory` where your working directory will be
- Update config with `sayMyName.characters` as a list of names equivalent to `tts.voice`


### Convert wem to wav WIP
```
wine ww2ogg.exe test.wem --pcb "./packed_codebooks_aoTuV_603.bin"
```


## TTS

Instructions
- Add `tts.directory` for where coqui-tts is installed (working directory)
- Add `tts.voice` for the character you're using
- Add `voices` folder to your `tts.directory`. Any wavs in that directory that start with your `tts.voice` text will be used to clone from