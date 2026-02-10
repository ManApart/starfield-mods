Scriptname AKAutoSortQuest extends Quest

;Import CassiopeiaPapyrusExtenders
;CassiopeiaPapyrusExtener Property Utils Auto Const


SortedChest[] Property TrackedChests Auto
Cell Property NoneCell Auto
ObjectReference Property NoneChest Auto

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
      containerToAdd.addKeyword(HardcodedKeyword)
      Debug.Notification("Chest is now tracked")
    endif
  else
    Debug.Notification("Chest is already tracked")
  endif
EndFunction

;TODO - remove function should clear formlist and set cell and object to none
function removeContainer(ObjectReference containerToAdd)
  Debug.Notification("Removing chest")
endFunction

function sortItems()
  Debug.Notification("Sorting Items")
  Actor player = Game.GetPlayer()
  Cell currentCell = player.GetParentCell()
  int i = TrackedChests.FindStruct("parentCell", currentCell)

  ;For each item in inventory, loop
  ;Find by cell, for each, do sort, move to next
  while (i != -1)
    SortedChest chest = TrackedChests[i]
    Debug.Notification("Found chest: " + chest.chest.GetFormID())
    i = TrackedChests.FindStruct("parentCell", currentCell, i+1)
  endWhile

  Debug.Notification("Sorting Complete")

EndFunction

; function doSort(Actor player, FormList chests)
;   Int sortedItems = 0
;   ; Form[] items = GetInventoryItems(player)

;   ; Int iPlayerItem = items.length
;   ; Debug.Notification("Sorting through " + iPlayerItem + " items into " + chests.GetSize() + " chests")
;     ; iPlayerItem -= 1
;     ; Form itemToSort = player.GetNthForm(iPlayerItem)
  
;     ; if (!player.IsEquipped(itemToSort) && !Game.IsObjectFavorited(itemToSort))
;     ; endif
;     return false
; endFunction

