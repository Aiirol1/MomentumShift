extends Walls


func spawnWall():
	setXCellsOnTop()
	setXCellsOnGround()

func setXCellsOnTop():
	var usedCells: Array[Vector2i] = getFloorCells()
	var xCells: Array[Vector2i] = floor.getTopTilesYValues()
	
	for value in xCells:
		if value.x > 0:
			set_cell(Vector2i(value.x, value.y), 0, Vector2i(1, 0), 0)
			
func setXCellsOnGround():
	var usedCells: Array[Vector2i] = getFloorCells()
	var xCells: Array[Vector2i] = floor.getGroundTilesYValues()
	
	for value in xCells:
		if value.x > 0:
			set_cell(Vector2i(value.x, value.y), 0, Vector2i(1, 0), 0)
			
