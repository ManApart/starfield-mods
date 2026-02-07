Scriptname AKSortTool extends ObjectReference Const

AKAutoSortQuest Property akQuest Auto Const

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
  Debug.Notification("Sort tool equipped by " + akActor)
EndEvent

Event OnActivate(ObjectReference akActionRef)
    Debug.Notification("Sort tool activated by " + akActionRef)
  if akActionRef == Game.GetPlayer()
    akQuest.sortItems()
  endif
EndEvent