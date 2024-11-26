extends TileMapLayer

@export var floor: TileMapLayer

func _ready():
	spawnWall()
	
	
func spawnWall():
	getYCellsOnLeft()


func getYCellsOnLeft():
	var usedCells: Array[Vector2i] = getFloorCells()
	var yCells: Array[Vector2i]
	
	yCells = getSmallestXValues(usedCells, floor.get_bounds().y)
	
	for value in yCells:
		set_cell(Vector2i(value.x + 2, value.y), 0, Vector2i(0, 0), 0)

	
func getSmallestXValues(array: Array[Vector2i], height: int) -> Array[Vector2i]:
	var smallestXValues: Array[Vector2i]
	
	for i in height:
		for value in array:
			if value.y == i:
				if smallestXValues.size() <= i:
					smallestXValues.append(value)
				elif value.x < smallestXValues[i].x:
					smallestXValues[i] = value

	return smallestXValues


func getFloorCells() -> Array[Vector2i]:
	var cells = floor.get_used_cells()
	return cells
