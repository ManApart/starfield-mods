Scriptname AKSortTool extends ObjectReference Const

AKAutoSortQuest Property akQuest Auto Const
Armor Property tool Auto Const

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
  if akNewContainer == Game.GetPlayer()
  elseif akNewContainer == None
    Game.GetPlayer().AddItem(self, 1, true)
  else
    akNewContainer.RemoveItem(self, 1, true, Game.GetPlayer())
    akQuest.addContainer(akNewContainer)
  endIf
endEvent

Event OnEquipped(Actor akActor)
  if akActor == Game.GetPlayer()
    akActor.unEquipItem(tool, false, true)
    akQuest.sortItems()
else
    Debug.Notification("Sort tool equipped by a non player " + akActor)
  endif
EndEvent

