Scriptname AKAutoSortQuest extends Quest conditional

Import CassiopeiaPapyrusExtender

SortedChest[] Property TrackedChests Auto
ExactMatchChest[] Property ExactMatchChests Auto
Cell Property NoneCell Auto
ObjectReference Property NoneChest Auto
ObjectReference Property selectedChest Auto
ActorValue Property CarryWeight Auto
bool Property AddKeyword Auto
bool Property selectedChestIsTracked Auto Conditional
Formlist Property ExcludeList Auto
Armor Property tool Auto Const

struct SortedChest
      Cell parentCell
      {Cell the chest is in}
      
      ObjectReference chest
      {Tracked Chest}

      FormList sortWords
      {Keywords Sorted into this chest}
endStruct

struct ExactMatchChest
      Cell parentCell
      {Cell the chest is in}
      
      ObjectReference chest
      {Tracked Chest}

      FormList sortItems
      {Exact list of items for this chest}
endStruct

function setSelectedChest(ObjectReference chest)
  selectedChest = chest
  selectedChestIsTracked = TrackedChests.FindStruct("chest", selectedChest) != -1
endFunction

function addSelectedContainer()
  addContainer(selectedChest)
endFunction

function addSelectedContainerAsExactMatch()
  addExactContainer(selectedChest)
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
  int chestO = ExactMatchChests.FindStruct("chest", containerToAdd)
  if (chestO != -1)
    Debug.Notification("Chest is tracked as exact match")
  elseif (chestI == -1)
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

function addExactContainer(ObjectReference containerToAdd)
  int chestI = ExactMatchChests.FindStruct("chest", containerToAdd)
  int chestO = TrackedChests.FindStruct("chest", containerToAdd)
  if (chestO != -1)
    Debug.Notification("Chest is tracked as keyword match")
  elseif (chestI == -1)
    int freeSlot = ExactMatchChests.FindStruct("chest", NoneChest)
    if (freeSlot == -1)
      Debug.Notification("There are no more slots. Please remove a chest.")
    else
      Actor player = Game.GetPlayer()
      Cell currentCell = player.GetParentCell()
      ExactMatchChest chest = ExactMatchChests[freeSlot]
      chest.parentCell = currentCell
      chest.chest = containerToAdd
      updateExactSortItems(chest)
    endif
  else
    updateExactSortItems(ExactMatchChests[chestI])
  endif
EndFunction

function updateExactSortItems(ExactMatchChest chest)
  Form[] items = GetInventoryItems(chest.chest, true)
  Int i = items.length
  chest.sortItems.Revert()
  while (i > 0)
    i -= 1
    chest.sortItems.addForm(items[i])
  endWhile
  Debug.Notification("Chest now grabs current contents. (" + items.length + ") items")
EndFunction

function removeSelectedContainer()
  removeContainer(selectedChest)
endFunction

function removeContainer(ObjectReference containerToRemove)
  int chestI = TrackedChests.FindStruct("chest", containerToRemove)
  int chestO = ExactMatchChests.FindStruct("chest", containerToRemove)
  if (chestI != -1)
    SortedChest chest = TrackedChests[chestI]
    chest.parentCell = NoneCell
    chest.chest = NoneChest
    chest.sortWords.Revert()
    Debug.Notification("Chest is no longer tracked")
  elseif (chestO != -1)
    ExactMatchChest chest = ExactMatchChests[chestO]
    chest.parentCell = NoneCell
    chest.chest = NoneChest
    chest.sortItems.Revert()
    Debug.Notification("Chest is no longer tracked")
  else
    Debug.Notification("Chest is not tracked")
  endif
endFunction

function printSortWords()
  int chestI = TrackedChests.FindStruct("chest", selectedChest)
  int chestO = ExactMatchChests.FindStruct("chest", selectedChest)
  if (chestO != -1)
    Debug.Notification("Chest matches on exact items")
  elseif (chestI == -1)
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
  float t0 = Utility.GetCurrentRealTime()
  Actor player = Game.GetPlayer()
  Cell currentCell = player.GetParentCell()
  Form[] items = GetInventoryItems(player, true)
  Int[] exactChestIndexes = getExactChestIndexesInCell(currentCell)
  Int[] trackedChestIndexes = getTrackedChestIndexesInCell(currentCell)
  ; Form[] favs = GetPlayerFavoritedForms()
  Int i = items.length
  Debug.Notification("Sorting " + i + " Items")

  while (i > 0)
    i -= 1
    Form item = items[i]
    ; && !ArrayContainsForm(favs, item)
    if (item != tool && !player.IsEquipped(item) && !ExcludeList.HasForm(item))
      sortItem(player, item, i, exactChestIndexes, trackedChestIndexes)
    endif
  endWhile

  Debug.Trace("Sorting took " + (t1 - t0) + " sec")
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

function sortItem(Actor player, Form item, int itemIndex, Int[] exactChestIndexes, Int[] trackedChestIndexes)
  int count = GetItemStackCount(player, itemIndex)
  if (!sortItemByExact(player, item, count, exactChestIndexes))
    sortItemByKeyword(player, item, count, trackedChestIndexes)
  endif
endFunction

bool function sortItemByExact(Actor player, Form item, int count, Int[] exactChestIndexes)
  int i = 0
  int chestCount = exactChestIndexes.Length
  while (i < chestCount)
    ExactMatchChest chest = ExactMatchChests[exactChestIndexes[i]]
    if (chest.sortItems.HasForm(item) && hasCapacity(chest.chest, item, count))
      player.RemoveItem(item, count, true, chest.chest)
      return true
    endif
    i += 1
  endWhile
  return false
endFunction

function sortItemByKeyword(Actor player, Form item, int count, Int[] trackedChestIndexes)
  int i = 0
  int chestCount = trackedChestIndexes.Length
  while (i < chestCount)
    SortedChest chest = TrackedChests[trackedChestIndexes[i]]
    if (item.HasKeywordInFormList(chest.sortWords) && hasCapacity(chest.chest, item, count))
      player.RemoveItem(item, count, true, chest.chest)
      return
    endif
    i += 1
  endWhile
endFunction

bool function hasCapacity(ObjectReference chest, Form item, int count)
  float currentFill = chest.GetWeightInContainer()
  float max = chest.GetValue(CarryWeight)
  float needed = item.GetWeight() * count
  return currentFill + needed <= max
endFunction

Int[] function getExactChestIndexesInCell(Cell currentCell)
  int matchCount = countExactChestsInCell(currentCell)
  Int[] indexes = new Int[matchCount]
  int sourceIndex = 0
  int matchIndex = 0
  int chestCount = ExactMatchChests.Length

  while (sourceIndex < chestCount)
    if (ExactMatchChests[sourceIndex].parentCell == currentCell)
      indexes[matchIndex] = sourceIndex
      matchIndex += 1
    endif
    sourceIndex += 1
  endWhile

  return indexes
endFunction

int function countExactChestsInCell(Cell currentCell)
  int sourceIndex = 0
  int matchCount = 0
  int chestCount = ExactMatchChests.Length

  while (sourceIndex < chestCount)
    if (ExactMatchChests[sourceIndex].parentCell == currentCell)
      matchCount += 1
    endif
    sourceIndex += 1
  endWhile

  return matchCount
endFunction

Int[] function getTrackedChestIndexesInCell(Cell currentCell)
  int matchCount = countTrackedChestsInCell(currentCell)
  Int[] indexes = new Int[matchCount]
  int sourceIndex = 0
  int matchIndex = 0
  int chestCount = TrackedChests.Length

  while (sourceIndex < chestCount)
    if (TrackedChests[sourceIndex].parentCell == currentCell)
      indexes[matchIndex] = sourceIndex
      matchIndex += 1
    endif
    sourceIndex += 1
  endWhile

  return indexes
endFunction

int function countTrackedChestsInCell(Cell currentCell)
  int sourceIndex = 0
  int matchCount = 0
  int chestCount = TrackedChests.Length

  while (sourceIndex < chestCount)
    if (TrackedChests[sourceIndex].parentCell == currentCell)
      matchCount += 1
    endif
    sourceIndex += 1
  endWhile

  return matchCount
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
