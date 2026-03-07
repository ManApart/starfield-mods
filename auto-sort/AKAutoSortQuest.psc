Scriptname AKAutoSortQuest extends Quest conditional

Import CassiopeiaPapyrusExtender
Import AK_SF_Utils


SortedChest[] Property TrackedChests Auto
Cell Property NoneCell Auto
ObjectReference Property NoneChest Auto
ObjectReference Property selectedChest Auto
ActorValue Property CarryWeight Auto
bool Property AddKeyword Auto
bool Property selectedChestIsTracked Auto Conditional
Formlist Property ExcludeList Auto

struct SortedChest
      Cell parentCell
      {Cell the chest is in}
      
      ObjectReference chest
      {Tracked Chest}

      FormList sortWords
      {Keywords Sorted into this chest}
endStruct

function setSelectedChest(ObjectReference chest)
  selectedChest = chest
  selectedChestIsTracked = TrackedChests.FindStruct("chest", selectedChest) != -1
endFunction

function addSelectedContainer()
  addContainer(selectedChest)
endFunction

bool function selectedChestHasSortWord(Keyword word)
  int chestI = TrackedChests.FindStruct("chest", selectedChest)
  if (chestI == -1)
    return false
  endif
  return TrackedChests[chestI].sortWords.HasForm(word)
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

function printSortWords()
 int chestI = TrackedChests.FindStruct("chest", selectedChest)
  if (chestI == -1)
    Debug.Notification("Chest is not tracked")
  else
    Form[] raw = TrackedChests[chestI].sortWords.GetArray()
    Int i = raw.length
    while (i > 0)
      i -= 1
      Debug.Notification(raw[i])
    endWhile
  endif
endFunction

function updateSortWords(Keyword word)
  int chestI = TrackedChests.FindStruct("chest", selectedChest)
  if (chestI == -1)
    Debug.Notification("Chest is not tracked")
  else
    SortedChest chest = TrackedChests[chestI]
    if (AddKeyword)
      addSortWords(chest, word)
    else
      removeSortWords(chest, word)
    endif
  endif
EndFunction

function addSortWords(SortedChest chest, Keyword word)
  chest.sortWords.addForm(word)
  Debug.Notification("Added word" + word)
EndFunction

function removeSortWords(SortedChest chest, Keyword word)
  chest.sortWords.removeAddedForm(word)
  Debug.Notification("Removed word" + word)
EndFunction

function sortItems()
  Actor player = Game.GetPlayer()
  Cell currentCell = player.GetParentCell()
  Form[] items = GetInventoryItems(player, true)
  ; Form[] favs = GetPlayerFavoritedForms()
  Int i = items.length
  Debug.Notification("Sorting " + i + " Items")

  while (i > 0)
    i -= 1
    Form item = items[i]
    ; && !ArrayContainsForm(favs, item)
    if (!player.IsEquipped(item) && !ExcludeList.HasForm(item))
      sortItem(player, currentCell, item, i)
    endif
  endWhile

  Debug.Notification("Sorting Complete")
EndFunction

bool Function ArrayContainsForm(Form[] forms, Form target)
    if forms == None || target == None
        return false
    endif

    int i = 0
    while i < forms.Length
        if forms[i] == target
            return true
        endif
        i += 1
    endwhile

    return false
EndFunction

bool Function ArrayContainsInt(Int[] arr, Int value)
    int i = 0
    while i < arr.Length
        if arr[i] == value
            return true
        endif
        i += 1
    endwhile
    return false
EndFunction

function sortItem(Actor player, Cell currentCell, Form item, int itemIndex)
  int i = TrackedChests.FindStruct("parentCell", currentCell)
  while (i != -1)
    SortedChest chest = TrackedChests[i]
    int count = GetItemStackCount(player, itemIndex)
    if (hasCapacity(chest.chest, item, count) && item.HasKeywordInFormList(chest.sortWords))
      player.RemoveItem(item, count, true, chest.chest)
      return
    endif

    i = TrackedChests.FindStruct("parentCell", currentCell, i+1)
  endWhile

endFunction

bool function hasCapacity(ObjectReference chest, Form item, int count)
  float currentFill = chest.GetWeightInContainer()
  float max = chest.GetValue(CarryWeight)
  float needed = item.GetWeight() * count
  return currentFill + needed <= max
endFunction

function addFavoritesInChest()
  Actor player = Game.GetPlayer()
  Form[] items = GetInventoryItems(selectedChest, true)
  Int i = items.length
  while (i > 0)
    i -= 1
    Form item = items[i]
    int count = GetItemStackCount(selectedChest, i)
    selectedChest.RemoveItem(item, count, true, player)
    player.MarkItemAsFavorite(item)
  endWhile

  Debug.Notification("Favorited " + items.length + " items")
endFunction

function addItemsInChestToExcludeList()
  Actor player = Game.GetPlayer()
  Form[] items = GetInventoryItems(selectedChest, true)
  Int i = items.length
  
  while (i > 0)
    i -= 1
    Form item = items[i]
    int count = GetItemStackCount(selectedChest, i)
    selectedChest.RemoveItem(item, count, true, player)
    ExcludeList.addForm(item)
  endWhile

  Debug.Notification("Excluded " + items.length + " items")
endFunction

function removeItemsInChestFromExcludeList()
  Actor player = Game.GetPlayer()
  Form[] items = GetInventoryItems(selectedChest, true)
  Int i = items.length
  
  while (i > 0)
    i -= 1
    Form item = items[i]
    int count = GetItemStackCount(selectedChest, i)
    selectedChest.RemoveItem(item, count, true, player)
    ExcludeList.removeAddedForm(item)
  endWhile

  Debug.Notification("Un-Excluded " + items.length + " items")
endFunction