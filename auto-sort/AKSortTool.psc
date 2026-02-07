Scriptname AKSortTool extends ObjectReference Const

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
  Debug.Notification("Tool Transfer")
  if akNewContainer == Game.GetPlayer()
    Debug.Notification("Player picked up sort tool")
  elseif akNewContainer == None
    Debug.Notification("Tool Dropped")
    Game.GetPlayer().AddItem(self, 1, true)
  else
    Debug.Notification("Tool Placed in container")
    akNewContainer.RemoveItem(self, 1, true, Game.GetPlayer())
  endIf
endEvent