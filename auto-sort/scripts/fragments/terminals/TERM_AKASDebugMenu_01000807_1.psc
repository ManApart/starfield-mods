;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname Fragments:Terminals:TERM_AKASDebugMenu_01000807_1 Extends TerminalMenu Hidden Const

;BEGIN FRAGMENT Fragment_TerminalMenu_01
Function Fragment_TerminalMenu_01(ObjectReference akTerminalRef)
;BEGIN CODE
akQuest.addSelectedContainer()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_02
Function Fragment_TerminalMenu_02(ObjectReference akTerminalRef)
;BEGIN CODE
akQuest.addFavoritesInChest()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_03
Function Fragment_TerminalMenu_03(ObjectReference akTerminalRef)
;BEGIN CODE
akQuest.addItemsInChestToExcludeList()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_04
Function Fragment_TerminalMenu_04(ObjectReference akTerminalRef)
;BEGIN CODE
akQuest.removeItemsInChestFromExcludeList()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_05
Function Fragment_TerminalMenu_05(ObjectReference akTerminalRef)
;BEGIN CODE
akQuest.setUntrackKind(0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_06
Function Fragment_TerminalMenu_06(ObjectReference akTerminalRef)
;BEGIN CODE
akQuest.setUntrackKind(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_07
Function Fragment_TerminalMenu_07(ObjectReference akTerminalRef)
;BEGIN CODE
akQuest.setUntrackKind(2)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

AKAutoSortQuest Property akQuest Auto Const
