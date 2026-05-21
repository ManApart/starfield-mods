Scriptname AKCCCredPrinter extends ObjectReference Const

MiscObject Property AKCCCredits100k Auto Const
MiscObject Property AKCCCredits100kEM Auto Const
MiscObject Property AKCCCredits1M Auto Const
MiscObject Property AKCCCredits1MEM Auto Const
MiscObject Property Credits Auto Const
Keyword Property AKCCCredKeyword Auto Const

Event OnInit()
  AddInventoryEventFilter(AKCCCredKeyword)
EndEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer, int aiTransferReason)
  if (akSourceContainer != Game.GetPlayer())
    return
  endif
  
  if (aiItemCount != 1)
    Debug.Notification("Only one stick can be used at a time!")
    return
  endif

  if (akBaseItem == AKCCCredits100k)
    unloadStick(akBaseItem, 100000, AKCCCredits100kEM)
  elseif (akBaseItem == AKCCCredits100kEM)
    loadStick(akBaseItem, 100000, AKCCCredits100k)
  elseif (akBaseItem == AKCCCredits1M)
    unloadStick(akBaseItem, 1000000, AKCCCredits1MEM)
  elseif (akBaseItem == AKCCCredits1MEM)
    loadStick(akBaseItem, 1000000, AKCCCredits1M)
  endif
EndEvent

function loadStick(Form akBaseItem, int amount, Form loaded)
  Actor player = Game.GetPlayer()
  int playerMoney = player.GetItemCount(Credits)
  if (playerMoney < amount)
    Debug.Notification("You don't have enough credits to load this stick")
    return
  endif
  RemoveItem(akBaseItem)
  player.removeItem(Credits, amount)
  AddItem(loaded)

EndFunction

function unloadStick(Form akBaseItem, int amount, Form emptyStick)
  RemoveItem(akBaseItem)
  AddItem(emptyStick)
  AddItem(Credits, amount)
EndFunction