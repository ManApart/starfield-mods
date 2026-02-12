Scriptname AKAutoSortQuest extends Quest

Import CassiopeiaPapyrusExtender


SortedChest[] Property TrackedChests Auto
Cell Property NoneCell Auto
ObjectReference Property NoneChest Auto
ObjectReference Property selectedChest Auto

;TODO - get keywords from menu and delete this
Keyword Property HardcodedKeyword auto

struct SortedChest
      Cell parentCell
      {Cell the chest is in}
      
      ObjectReference chest
      {Tracked Chest}

      FormList sortWords
      {Keywords Sorted into this chest}
endStruct

function addSelectedContainer()
  addContainer(selectedChest)
endFunction

function addContainer(ObjectReference containerToAdd)
  int chestI = TrackedChests.FindStruct("chest", containerToAdd)
  if (chestI == -1)
    int freeSlot = TrackedChests.FindStruct("chest", NoneChest)
    if (freeSlot == -1)
      Debug.Notification("There are no more slots. Please remove a chest.")
    else
      Actor player = Game.GetPlayer()
      Cell currentCell = player.GetParentCell()
      SortedChest chest = TrackedChests[freeSlot]
      chest.parentCell = currentCell
      chest.chest = containerToAdd
      ;Hard code for now
      chest.sortWords.addForm(HardcodedKeyword)
      Debug.Notification("Chest is now tracked")
    endif
  else
    Debug.Notification("Chest is already tracked")
  endif
EndFunction

function removeSelectedContainer()
  removeContainer(selectedChest)
endFunction

function removeContainer(ObjectReference containerToRemove)
  int chestI = TrackedChests.FindStruct("chest", containerToRemove)
  if (chestI == -1)
    Debug.Notification("Chest is not tracked")
  else
    SortedChest chest = TrackedChests[chestI]
    chest.parentCell = NoneCell
    chest.chest = NoneChest
    chest.sortWords.Revert()
    Debug.Notification("Chest is no longer tracked")
  endif
endFunction

Form[] function getSortWords()
 int chestI = TrackedChests.FindStruct("chest", selectedChest)
  if (chestI == -1)
    Debug.Notification("Chest is not tracked")
    return new Form[0]
  else
    return TrackedChests[chestI].sortWords.GetArray()
  endif
endFunction

function sortItems()
  Actor player = Game.GetPlayer()
  Cell currentCell = player.GetParentCell()
  Form[] items = GetInventoryItems(player, true)
  Int i = items.length
  Debug.Notification("Sorting " + i + " Items")

  while (i > 0)
    i -= 1
    Form item = items[i]
    ;TODO - don't move favorites
    if (!player.IsEquipped(item))
      sortItem(player, currentCell, item, i)
    endif
  endWhile

  Debug.Notification("Sorting Complete")
EndFunction

function sortItem(Actor player, Cell currentCell, Form item, int itemIndex)
  ;Find chests by cell, for each, do sort, move to next
  int i = TrackedChests.FindStruct("parentCell", currentCell)
  while (i != -1)
    SortedChest chest = TrackedChests[i]
    if (item.HasKeywordInFormList(chest.sortWords))
      int count = GetItemStackCount(player, itemIndex)
      player.RemoveItem(item, count, true, chest.chest)
      return
    endif

    i = TrackedChests.FindStruct("parentCell", currentCell, i+1)
  endWhile

endFunction

