Scriptname AKAutoSortQuest extends Quest


Cell[] Property TrackedCells Auto
FormList[] Property TrackedChests Auto
int Property TrackedCellCount auto

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
    Debug.Notification("Found " + chests.GetSize()  + " tracked chests")
  endif

EndFunction