;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname Fragments:Terminals:TERM_AKASTagObjectType_01000E9E Extends TerminalMenu Hidden Const

;BEGIN FRAGMENT Fragment_TerminalMenu_01
Function Fragment_TerminalMenu_01(ObjectReference akTerminalRef)
;BEGIN CODE
akQuest.updateSortWords(ObjectTypeAmmo)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_02
Function Fragment_TerminalMenu_02(ObjectReference akTerminalRef)
;BEGIN CODE
akQuest.updateSortWords(ObjectTypeAid)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_03
Function Fragment_TerminalMenu_03(ObjectReference akTerminalRef)
;BEGIN CODE
akQuest.updateSortWords(ObjectTypeAlcohol)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_TerminalMenu_04
Function Fragment_TerminalMenu_04(ObjectReference akTerminalRef)
;BEGIN CODE
akQuest.updateSortWords(ObjectTypeArmor)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
AKAutoSortQuest Property akQuest Auto Const
Keyword Property ObjectTypeAmmo Auto Const
Keyword Property ObjectTypeAid Auto Const
Keyword Property ObjectTypeAlcohol Auto Const
Keyword Property ObjectTypeArmor Auto Const
Keyword Property ObjectTypeChem Auto Const
Keyword Property ObjectTypeDataSlate Auto Const
Keyword Property ObjectTypeJunk Auto Const
Keyword Property ObjectTypeKeycard Auto Const
Keyword Property ObjectTypeMissionCargo Auto Const
Keyword Property ObjectTypePlanetSurveySlate Auto Const
Keyword Property ObjectTypeShipRepairKit Auto Const
Keyword Property ObjectTypeStimpak Auto Const
Keyword Property ObjectTypeWater Auto Const
Keyword Property ObjectTypeWeapon Auto Const
