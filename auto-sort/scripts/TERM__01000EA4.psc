;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname Fragments:Terminals:TERM__01000EA4 Extends TerminalMenu Hidden Const

;BEGIN FRAGMENT Fragment_TerminalMenu_01
Function Fragment_TerminalMenu_01(ObjectReference akTerminalRef)
;BEGIN CODE
akQuest.updateSortWords(ResourceTypeFauna)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_02
Function Fragment_TerminalMenu_02(ObjectReference akTerminalRef)
;BEGIN CODE
akQuest.updateSortWords(ResourceTypeFlora)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_03
Function Fragment_TerminalMenu_03(ObjectReference akTerminalRef)
;BEGIN CODE
akQuest.updateSortWords(ResourceTypeGas)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_04
Function Fragment_TerminalMenu_04(ObjectReference akTerminalRef)
;BEGIN CODE
akQuest.updateSortWords(ResourceTypeLiquid)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_05
Function Fragment_TerminalMenu_05(ObjectReference akTerminalRef)
;BEGIN CODE
akQuest.updateSortWords(ResourceTypeManufactured)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_06
Function Fragment_TerminalMenu_06(ObjectReference akTerminalRef)
;BEGIN CODE
akQuest.updateSortWords(ResourceTypeOrganic)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_07
Function Fragment_TerminalMenu_07(ObjectReference akTerminalRef)
;BEGIN CODE
akQuest.updateSortWords(ResourceTypeSolid)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
AKAutoSortQuest Property akQuest Auto Const
Keyword Property ResourceTypeFauna Auto Const
Keyword Property ResourceTypeFlora Auto Const
Keyword Property ResourceTypeGas Auto Const
Keyword Property ResourceTypeLiquid Auto Const
Keyword Property ResourceTypeManufactured Auto Const
Keyword Property ResourceTypeOrganic Auto Const
Keyword Property ResourceTypeSolid Auto Const
