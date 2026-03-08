Scriptname AKASViewKeywords extends TerminalMenu

AKAutoSortQuest Property akQuest Auto Const

Event OnTerminalMenuEnter(TerminalMenu akTerminalBase, ObjectReference akTerminalRef)
  akTerminalBase.ClearDynamicMenuItems(akTerminalRef)

  Form[] words = akQuest.getSortWords()
  Debug.notification("Found " + words.length +" words")

  int i = 0
  while i < words.Length
      Keyword kw = words[i] as Keyword

      ; Replace <Alias=Word> with the keyword form so UI shows its name
      Form[] tags = new Form[1]
      tags[0] = kw

      int itemID = 5000 + i
      akTerminalBase.AddDynamicMenuItem(akTerminalRef, 0, itemID, tags)

      i += 1
  endWhile
EndEvent