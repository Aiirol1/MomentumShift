extends Walls


func spawnWall():
	setYCellsOnLeft()
	setYCellsOnRight()

func setYCellsOnLeft():
	var usedCells: Array[Vector2i] = getFloorCells()
	var yCells: Array[Vector2i] = floor.getLeftTilesXValues()
	
	for value in yCells:
		if value.y > 0:
			set_cell(Vector2i(value.x, value.y), 0, Vector2i(0, 0), 0)
			if !floor.hasTileOnLeftSide(value):
				set_cell(Vector2i(value.x - 1, value.y), 0, Vector2i(0, 0), 0)

			
func setYCellsOnRight():
	var usedCells: Array[Vector2i] = getFloorCells()
	var yCells: Array[Vector2i] = floor.getRightTilesXValues()
	
	for value in yCells:
		if value.y > 0:
			set_cell(Vector2i(value.x, value.y), 0, Vector2i(0, 0), 0)
			if floor.hasTileOnLeftSide(value):
				set_cell(Vector2i(value.x + 1, value.y), 0, Vector2i(0, 0), 0)
			
