Scriptname AKARAstraPrinter extends ObjectReference Const

MiscObject Property Astra Auto Const
MiscObject Property Credits Auto Const

Keyword Property ResourceRarity04Unique Auto Const

MiscObject Property XTech Auto Const


Event OnInit()
  AddInventoryEventFilter(ResourceRarity04Unique)
EndEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer, int aiTransferReason)
  Actor player = Game.GetPlayer()
  if (akSourceContainer != player || akBaseItem != XTech)
    return
  endif
  
  int maxAstraPerCredits = player.GetItemCount(Credits) / 30000
  int astraCount = aiItemCount
  if (maxAstraPerCredits < astraCount)
    astraCount = maxAstraPerCredits
  endif
  if (astraCount <= 0)
    Debug.Notification("Not enough resources!")
  endif

  AddItem(Astra, astraCount)
  player.removeItem(Credits, astraCount * 30000)
  removeItem(XTech, astraCount)
  
EndEvent