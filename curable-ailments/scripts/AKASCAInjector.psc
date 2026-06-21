Scriptname AKASCAInjector extends ObjectReference Const

Int Property Level Auto Const
Keyword Property AKCACureKeyword Auto Const

Event OnInit()
  AddInventoryEventFilter(AKCACureKeyword)
EndEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer, int aiTransferReason)
  AKCACure cure = akBaseItem as AKCACure
  if (cure == none)
    Debug.Notification("Not a cure.")
    return
  endif
  if (aiItemCount != 1)
    Debug.Notification("Only one cure may be administered at a time.")
    return
  endif
  
  if (cure.Level > Level)
    Debug.Notification("Cure is too sophisticated to administer with current device.")
    return
  endif

  Int i = 0
  Actor player = Game.getPlayer()
  while (i < cure.CureList.length)
    Spell ailment = cure.CureList[i]
    if (player.HasSpell(ailment))
      if (player.GetValueInt(cure.Prognosis) == 0)
        Debug.Notification("This procedure requires the affliction to be at least stable prognoses.")
        return
      endif

      player.RemoveSpell(ailment)
      self.removeItem(cure)
      Debug.Notification("Procedure successful.")
      return
    endif
  i +=1
  endwhile
  Debug.Notification("Nothing to cure")
EndEvent