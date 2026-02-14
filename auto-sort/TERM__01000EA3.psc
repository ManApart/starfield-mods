;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname Fragments:Terminals:TERM__01000EA3 Extends TerminalMenu Hidden Const

;BEGIN FRAGMENT Fragment_TerminalMenu_01
Function Fragment_TerminalMenu_01(ObjectReference akTerminalRef)
;BEGIN CODE
;akQuest.updateSortWords(InventoryCategoryAidDrink)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_02
Function Fragment_TerminalMenu_02(ObjectReference akTerminalRef)
;BEGIN CODE
akQuest.updateSortWords(InventoryCategoryAidFood)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_03
Function Fragment_TerminalMenu_03(ObjectReference akTerminalRef)
;BEGIN CODE
akQuest.updateSortWords(InventoryCategoryApparel)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_04
Function Fragment_TerminalMenu_04(ObjectReference akTerminalRef)
;BEGIN CODE
akQuest.updateSortWords(InventoryCategoryArmorBackpack)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_05
Function Fragment_TerminalMenu_05(ObjectReference akTerminalRef)
;BEGIN CODE
akQuest.updateSortWords(InventoryCategoryArmorHelmet)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_06
Function Fragment_TerminalMenu_06(ObjectReference akTerminalRef)
;BEGIN CODE
akQuest.updateSortWords(InventoryCategoryArmorSuit)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_07
Function Fragment_TerminalMenu_07(ObjectReference akTerminalRef)
;BEGIN CODE
akQuest.updateSortWords(InventoryCategoryWeaponThrowable)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
AKAutoSortQuest Property akQuest Auto Const

Keyword Property InventoryCategoryAidDrink Auto Const
Keyword Property InventoryCategoryAidFood Auto Const
Keyword Property InventoryCategoryApparel Auto Const
Keyword Property InventoryCategoryArmorBackpack Auto Const
Keyword Property InventoryCategoryArmorHelmet Auto Const
Keyword Property InventoryCategoryArmorSuit Auto Const
Keyword Property InventoryCategoryWeaponThrowable Auto Const
