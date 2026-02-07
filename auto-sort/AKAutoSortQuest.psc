Scriptname AKAutoSortQuest extends Quest


 struct SortCell
 	Cell sortCell
	{Cell the chests are in}

 	FormList chests
 	{The tracked chests}
 endStruct

SortCell[] Property sortedCells Auto
Cell[] Property Cells Auto
int Property trackedCells auto

function addContainer(ObjectReference containerToAdd)
  Actor player = Game.GetPlayer()
  Cell currentCell = player.GetParentCell()
  ; int cellI = Cells.FindStruct("sortCell", currentCell, 0)
  int cellI = Cells.Find(currentCell)
  Debug.Notification(trackedCells + " tracked. Found cell at " + cellI)
  
  ;Add Cell struct if needed
  if (cellI == -1)
    cellI = trackedCells
    trackedCells +=1
    Debug.Notification("Cell doesn't exist, tracking at " + trackedCells)
    Cells[cellI] = currentCell
    ; cellI = Cells.Length
		; SortCell c2 = new SortCell
    ; c2.sortCell = currentCell
    ; c2.chests = new FormList
    ;Cells.add
  endif


  ; chests.AddForm(containerToAdd)

EndFunction

function sortItems()
  Actor player = Game.GetPlayer()
  Cell currentCell = player.GetParentCell()
EndFunction