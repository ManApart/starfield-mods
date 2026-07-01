ScriptName SFBGS00D:Fragments:Quests:QF_SFFL_R02_0202A418 Extends Quest Const hidden

;-- Variables ---------------------------------------

;-- Properties --------------------------------------
GlobalVariable Property SFFL_R02_RandomInt Auto Const mandatory
ReferenceAlias Property Alias_GenNPC Auto Const mandatory
Faction Property PlayerEnemyFaction Auto Const mandatory
ReferenceAlias Property Alias_ProofOfDeath Auto Const mandatory
GlobalVariable Property SFFL_R02_BribeAmount Auto Const mandatory
GlobalVariable Property LetTargetGo Auto Const mandatory
GlobalVariable Property TimesCompleted Auto Const mandatory
ReferenceAlias Property Alias_CaptiveNPC Auto Const mandatory
Faction Property CaptiveFaction Auto Const mandatory
ReferenceAlias Property Alias_ProofOfDeath01 Auto Const mandatory
GlobalVariable Property Cooldown Auto Const mandatory
GlobalVariable Property GameDaysPassed Auto Const mandatory
ActorValue Property SFFL_R02_Completed Auto Const mandatory
Quest Property DialogueQuest Auto Const mandatory
GlobalVariable Property KillCount Auto Const mandatory

;-- Functions ---------------------------------------

Function Fragment_Stage_0005_Item_00()
  DialogueQuest.Stop() ; #DEBUG_LINE_NO:7
EndFunction

Function Fragment_Stage_0100_Item_00()
  SFFL_R02_RandomInt.SetValue(Utility.RandomInt(1, 2) as Float) ; #DEBUG_LINE_NO:18
  SFFL_R02_BribeAmount.SetValue(Utility.RandomInt(100, 2500) as Float) ; #DEBUG_LINE_NO:21
  Self.UpdateCurrentInstanceGlobal(SFFL_R02_BribeAmount) ; #DEBUG_LINE_NO:22
EndFunction

Function Fragment_Stage_0200_Item_00()
  Self.SetObjectiveDisplayed(200, True, False) ; #DEBUG_LINE_NO:31
  SFFL_R02_RandomInt.SetValue(Utility.RandomInt(1, 10) as Float) ; #DEBUG_LINE_NO:34
  Self.setstage(201) ; #DEBUG_LINE_NO:36
EndFunction

Function Fragment_Stage_0200_Item_01()
  Self.SetObjectiveDisplayed(201, True, False) ; #DEBUG_LINE_NO:45
  SFFL_R02_RandomInt.SetValue(Utility.RandomInt(1, 10) as Float) ; #DEBUG_LINE_NO:48
  Self.setstage(202) ; #DEBUG_LINE_NO:50
EndFunction

Function Fragment_Stage_0210_Item_00()
  If Self.getstagedone(201) == True ; #DEBUG_LINE_NO:58
    Alias_GenNPC.GetActorRef().AddToFaction(PlayerEnemyFaction) ; #DEBUG_LINE_NO:60
    Alias_GenNPC.GetActorRef().StartCombat(Game.GetPlayer() as ObjectReference, False) ; #DEBUG_LINE_NO:61
  ElseIf Self.getstagedone(202) == True ; #DEBUG_LINE_NO:62
    Actor Captive = Alias_CaptiveNPC.GetActorRef() ; #DEBUG_LINE_NO:64
    Captive.EvaluatePackage(False) ; #DEBUG_LINE_NO:65
    Captive.RemoveFromFaction(CaptiveFaction) ; #DEBUG_LINE_NO:66
    Captive.AddToFaction(PlayerEnemyFaction) ; #DEBUG_LINE_NO:67
    Captive.StartCombat(Game.GetPlayer() as ObjectReference, False) ; #DEBUG_LINE_NO:68
  EndIf
EndFunction

Function Fragment_Stage_0215_Item_00()
  If Self.getstagedone(201) == True ; #DEBUG_LINE_NO:77
    Alias_GenNPC.GetActorRef().RemoveItem(Alias_ProofOfDeath.GetRef() as Form, 1, False, None) ; #DEBUG_LINE_NO:78
    Game.GetPlayer().AddItem(Alias_ProofOfDeath.GetRef() as Form, 1, False) ; #DEBUG_LINE_NO:79
  ElseIf Self.getstagedone(202) == True ; #DEBUG_LINE_NO:80
    Alias_CaptiveNPC.GetActorRef().RemoveItem(Alias_ProofOfDeath01.GetRef() as Form, 1, False, None) ; #DEBUG_LINE_NO:81
    Game.GetPlayer().AddItem(Alias_ProofOfDeath01.GetRef() as Form, 1, False) ; #DEBUG_LINE_NO:82
  EndIf
  Self.setstage(250) ; #DEBUG_LINE_NO:85
  Self.SetObjectiveDisplayed(200, False, False) ; #DEBUG_LINE_NO:86
  LetTargetGo.Mod(1.0) ; #DEBUG_LINE_NO:89
EndFunction

Function Fragment_Stage_0225_Item_00()
  KillCount.Mod(1.0) ; #DEBUG_LINE_NO:98
  If KillCount.GetValue() >= 10.0 ; #DEBUG_LINE_NO:101
    Game.AddAchievement(78) ; #DEBUG_LINE_NO:102
  EndIf
  Self.SetObjectiveDisplayed(225, True, False) ; #DEBUG_LINE_NO:106
  If Self.isobjectivedisplayed(200) == True ; #DEBUG_LINE_NO:108
    Self.SetObjectiveCompleted(200, True) ; #DEBUG_LINE_NO:109
  ElseIf Self.isobjectivedisplayed(201) == True ; #DEBUG_LINE_NO:110
    Self.SetObjectiveCompleted(201, True) ; #DEBUG_LINE_NO:111
  EndIf
EndFunction

Function Fragment_Stage_0250_Item_00()
  Self.SetObjectiveDisplayed(250, True, False) ; #DEBUG_LINE_NO:120
  Self.SetObjectiveCompleted(225, True) ; #DEBUG_LINE_NO:121
  If Self.isobjectivecompleted(200) == False && Self.isobjectivedisplayed(200) == True ; #DEBUG_LINE_NO:124
    Self.SetObjectiveDisplayed(200, False, False) ; #DEBUG_LINE_NO:125
  ElseIf Self.isobjectivecompleted(201) == False && Self.isobjectivedisplayed(201) == True ; #DEBUG_LINE_NO:126
    Self.SetObjectiveDisplayed(201, False, False) ; #DEBUG_LINE_NO:127
  EndIf
EndFunction

Function Fragment_Stage_1000_Item_00()
  Self.CompleteAllObjectives() ; #DEBUG_LINE_NO:136
  Game.GetPlayer().RemoveItem(Alias_ProofOfDeath.GetRef() as Form, 1, False, None) ; #DEBUG_LINE_NO:137
  TimesCompleted.Mod(1.0) ; #DEBUG_LINE_NO:140
  Cooldown.SetValue(GameDaysPassed.GetValue() + 1.5) ; #DEBUG_LINE_NO:143
  Game.GetPlayer().SetValue(SFFL_R02_Completed, 1.0) ; #DEBUG_LINE_NO:146
  DialogueQuest.Start() ; #DEBUG_LINE_NO:149
  Self.Stop() ; #DEBUG_LINE_NO:151
EndFunction

Function Fragment_Stage_1000_Item_01()
  Self.CompleteAllObjectives() ; #DEBUG_LINE_NO:159
  Game.GetPlayer().RemoveItem(Alias_ProofOfDeath.GetRef() as Form, 1, False, None) ; #DEBUG_LINE_NO:160
  TimesCompleted.Mod(1.0) ; #DEBUG_LINE_NO:163
  Cooldown.SetValue(GameDaysPassed.GetValue() + 1.5) ; #DEBUG_LINE_NO:166
  Game.GetPlayer().SetValue(SFFL_R02_Completed, 1.0) ; #DEBUG_LINE_NO:169
  DialogueQuest.Start() ; #DEBUG_LINE_NO:172
  Self.Stop() ; #DEBUG_LINE_NO:174
EndFunction

Function Fragment_Stage_1000_Item_02()
  Self.CompleteAllObjectives() ; #DEBUG_LINE_NO:182
  Game.GetPlayer().RemoveItem(Alias_ProofOfDeath.GetRef() as Form, 1, False, None) ; #DEBUG_LINE_NO:183
  TimesCompleted.Mod(1.0) ; #DEBUG_LINE_NO:186
  DialogueQuest.Start() ; #DEBUG_LINE_NO:189
  Self.Stop() ; #DEBUG_LINE_NO:191
EndFunction
