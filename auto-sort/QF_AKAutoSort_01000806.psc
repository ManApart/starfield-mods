;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname Fragments:Quests:QF_AKAutoSort_01000806 Extends Quest Hidden Const

;BEGIN FRAGMENT Fragment_Stage_0000_Item_00
Function Fragment_Stage_0000_Item_00()
;BEGIN CODE
ObjectReference tool = Game.GetPlayer().PlaceAtMe(PAKSortTool)
Game.GetPlayer().addItem(tool, 1, true)
Debug.Notification("Configured Auto Store")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

MiscObject Property PAKSortTool Auto Const Mandatory
