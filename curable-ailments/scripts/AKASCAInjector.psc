Scriptname AKASCAInjector extends ObjectReference Const

Int Property Level Auto Const
MagicEffect[] Property BadPrognosis Auto Const
Keyword Property AKCACureKeyword Auto Const
SQ_ENV_AfflictionsScript Property sq_env Auto const

Event OnInit()
  AddInventoryEventFilter(AKCACureKeyword)
EndEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer, int aiTransferReason)
  AKCACure cure = akBaseItem as AKCACure
  if (cure == none)
    Debug.Notification("Not a cure!")
    return
  endif
  
  if (cure.Level > Level)
    Debug.Notification("Cure is too sophisticated to administer.")
    return
  endif

  Actor player = Game.getPlayer()
  Int i = 0
  while (i < BadPrognosis.length)
    if (player.HasMagicEffect(BadPrognosis[i]))
      Debug.Notification("This procedure requires excellent prognoses for all ailments.")
      ; Skip check since test auto healing
      ; return
    endif
    i+=1
  endwhile

  Debug.Notification("Administering Cure")

  i = 0
  while (i < cure.CureList.length)
    Spell ailment = cure.CureList[i]
    if (player.HasSpell(ailment))
      player.RemoveSpell(ailment)
      self.removeItem(cure)
      Debug.Notification(ailment + " has been cured")
      return
    endif
  i +=1
  endwhile
  Debug.Notification("Nothing to cure")
EndEvent