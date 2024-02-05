I love how Vasco can say 1000 player names. It's such a neat immersion booster. When I saw all the recent developments in AI, I thought it would be cool to use AI to have more characters say your name. To do the project, I wanted to find an AI that was free and could be run locally (not in the cloud).

The goal of this mod is to feature nearly all the same player names as Vasco says in the game, with the possibility of adding names by request, for a period of time. (See Requests and bug reports below).

There will be different download options for different names, and I'll create a new mod for each new character (and link to them in the descriptions).

I'll add a video in the video section for a preview of the voice, and you can see all the lines that are changed by looking at the text files on [url=https://github.com/ManApart/starfield-mods/blob/master/tools/reference/sayMyName/]gihub[/url].

To see which file to download, see the name groups listed [url=https://github.com/ManApart/starfield-mods/blob/master/tools/reference/sayMyName/name-groups.txt]here[/url]. Each line in this file should be a different zip file.

[youtube]_zntlo4DgnQ[/youtube]

If you like this mod, check out my [url=https://manapart.github.io/starfield-eye/#about]companion app[/url], and my [url=https://www.nexusmods.com/starfield/users/1398716?tab=user+files]other Starfield mods[/url]

Say My Name Mods
[list]
[*][url=https://www.nexusmods.com/starfield/mods/8186?tab=description]Andreja[/url]﻿
[*][url=https://www.nexusmods.com/starfield/mods/8297]Sarah[/url]﻿
[/list]

[b]## Limits
[/b]
Because this is generated locally, the quality isn't the best on the market. (At this scale, something like using eleven labs would be expensive and time consuming).

I hope people will enjoy this mod and find it immersive, and not just hate on the sound quality. I'm splicing the name into the existing voice line, and there is a clear quality difference between the name and the rest of the line. If you're not paying attention, or in a busy soundscape, I think it does the job, but it's clearly not perfect. If it's not high enough quality for you, please don't waste your time complaining and instead build something better.

Until the Creation Kit is out, I can't update the lip sync files or dialogue text, so the name and any words after the name won't be lip synced or show the name in text. Once the creation kit comes out, I hope to mass generate lip sync files, but there is no guarantee I'll be able to do that in a scalable way.

[b]## Future Plans[/b]

- If the mod is well received, for some period of time I'll upload additional packs of requested names that meet the constraints below
- Again if the mod is well received, I plan to do additional characters, starting with constellation and _possibly_ branching out to other crew (Sam will likely be skipped as I believe the actor is against AI


[b]## Installation[/b]

Names will be broken up into folders alphabetically, so you don't have to download a too-massive file just for your player name. Installation requires a manual step, even if using a mod manager. Navigate to `/Data/sound/voice/starfield.esm/` and then find the folder with the player name you want. Copy all the files inside that folder to the <npc> folder, and then delete all the name folders. I[b]f you don't do this step, you won't hear your voice lines![/b]

If you've done it correctly, your mod folder (or Data folder in the game) should look like: `Data/sound/voice/starfield.esm/npcfandreja/00ae4a02.wem`, with a bunch of wem files.

[img]https://staticdelivery.nexusmods.com/mods/4187/images/8186/8186-1705926875-311253215.png[/img]

[b]## How This Was Made[/b]

All the source code is available on [url=https://github.com/ManApart/starfield-mods/blob/master/tools/src/main/kotlin/readme.md]github[/url]. While it's hard coded to my use case, it's possible to adjust it to your own workflow if you wanted to do something similar.

Showcase images were made with [url=https://github.com/lllyasviel/Fooocus]fooocus[/url].

Basically, I'm using [url=https://coqui.ai/]https://coqui.ai/[/url] running locally to generate each line I want, cloning the NPC voice but inserting a given player name. (Generating most of the original line gives the AI the context so it says the name with generally the right inflection). Then I crop out the name using an automated process that crops based on silences around the name. Then I stitch that name into the original line, which I've manually split into prefix and suffix, and normalize the volume. When this doesn't work, an automated fallback generates just the name without context, which may sound more jarring but was needed to accomplish this scale.

Once the new line is created, I copy it over to WWise to turn the wav into a wem, and then copy it back, remove the wwise filename suffix, and place it in the mod staging folder. Then I group and zip the folders.

While the process is highly automated, there are still a number of manual touch points, and the line generation itself takes quite a few hours per group of names. (Initially this was taking overnight just for a couple letters worth of names, but eventually I was able to optimize the process to be faster).

[b]## Making Requests and Reporting Bugs[/b]

If this mod is positively received, I'm considering doing requests for people. That said, I have some stringent constraints to prevent my own burnout.

- For both requests for new names as well as bug reports, please use the comments section.
- Please note that if any of these criteria are not met, I intend to not even respond to your post, again, for my own burnout prevention.

If you don't like these constraints, you can check out the source code on github, modify it to your needs, and do it yourself.

[b]### Constraints
[/b]
I enjoy modding for myself and sharing that work with others. That said, I don't enjoy doing customer support, and I _still_ get pings for mods I made over a decade ago.
This is a massive scale in terms of detail and it took a ton of work to set up. I want to keep making mods that I think are cool, but a mod like this has the possibility of sucking me into perpetual support and burnout, which I'm not interested in doing.

If you'd like to make a request, please consider the following constraints:

- At some point I'll stop doing requests. This mod released in 2024. Please don't DM me five years from now asking for something.
- I won't make names that are inappropriate or slurs. This is something I don't have interest in, and I also want to respect the original voice actors
- English only
- Names should be between 1 and 3 syllables
- Names should be a single word
- If a name is not pronounced correctly, there is not really anything I can do within my current workflow
- If a line for a given name is not saying the name, please report it by giving me the player name as well as the line id. You can look this up in [url=https://github.com/ManApart/starfield-mods/blob/master/tools/reference/sayMyName/]github[/url] based on the character name and words. If you don't care enough to look up the id, I won't care enough to fix the line. 

I'll likely do names in larger batches, which means I may not respond to your request immediately, but instead wait for a larger number of requests before producing another batch.