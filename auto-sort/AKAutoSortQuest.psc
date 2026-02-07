Scriptname AKAutoSortQuest extends Quest


Cell[] Property TrackedCells Auto
FormList[] Property TrackedChests Auto
int Property TrackedCellCount auto
;TODO - get keywords from menu and delete this
Keyword Property HardcodedKeyword auto

function addContainer(ObjectReference containerToAdd)
  Actor player = Game.GetPlayer()
  Cell currentCell = player.GetParentCell()
  int cellI = TrackedCells.Find(currentCell)
  Debug.Notification(TrackedCellCount + " tracked. Found cell at " + cellI)
  
  ;Add Cell if needed
  if (cellI == -1)
    cellI = TrackedCellCount
    TrackedCellCount +=1
    Debug.Notification("Cell doesn't exist, set CellI to " + cellI)
    TrackedCells[cellI] = currentCell
  endif

  containerToAdd.addKeyword(HardcodedKeyword)
  FormList chests = TrackedChests[cellI]
  chests.AddForm(containerToAdd)
  Debug.Notification("Now tracking " +chests.GetSize() + " chests in "+ CellI +", chest contained : "+ chests.HasForm(containerToAdd))
  Debug.Notification(chests)

EndFunction

function sortItems()
  Actor player = Game.GetPlayer()
  Cell currentCell = player.GetParentCell()
  int cellI = TrackedCells.Find(currentCell)
   if (cellI == -1)
    Debug.Notification("Cell doesn't exist, Not sorting")
  Else
    FormList chests = TrackedChests[cellI]
    doSort(player, chests)
  endif

EndFunction

function doSort(Actor player, FormList chests)
  Int sortedItems = 0
  ;This doesn't exist in SF
  ; Int iPlayerItem = player.GetNumItems()
  ; Debug.Notification("Sorting through " + iPlayerItem + " items into " + chests.GetSize() + " chests")
    ; iPlayerItem -= 1
    ; Form itemToSort = player.GetNthForm(iPlayerItem)
  
    ; if (!player.IsEquipped(itemToSort) && !Game.IsObjectFavorited(itemToSort))
    ; endif
endFunction