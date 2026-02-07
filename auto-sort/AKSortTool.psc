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
    Debug.Notification("Sort tool has been equipped by " + akActor)
    akActor.unEquipItem(tool)
    akQuest.sortItems()
else
    Debug.Notification("Not the player " + akActor)
  endif
EndEvent

