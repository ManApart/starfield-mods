Scriptname AKAutoSortEffect extends ActiveMagicEffect

AKAutoSortQuest Property akQuest Auto Const

Event OnEffectStart(ObjectReference akTarget, Actor akCaster, MagicEffect akBaseEffect, float afMagnitude, float afDuration)
  if akCaster == Game.GetPlayer()
    akquest.sortItems()
  endif
endEvent