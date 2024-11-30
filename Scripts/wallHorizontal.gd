extends Walls


func spawnWall():
	setXCellsOnTop()
	setXCellsOnGround()
	

func setXCellsOnTop():
	var xCells: Array[Vector2i] = floor.getTopTilesYValues()
	
	for value in xCells:
		if value.x > 0:
			set_cell(Vector2i(value.x, value.y), 0, Vector2i(1, 0), 0)
			if !floor.hasTileOnTop(value):
				set_cell(Vector2(value.x, value.y - 1), 0, Vector2i(1, 0), 0)

			
func setXCellsOnGround():
	var xCells: Array[Vector2i] = floor.getGroundTilesYValues()
	
	for value in xCells:
		if value.x > 0:
			set_cell(Vector2i(value.x, value.y), 0, Vector2i(1, 0), 0)
			if floor.hasTileOnTop(value): ##close free gaps if gap is > 1
				set_cell(Vector2(value.x, value.y + 1 ), 0, Vector2i(1, 0), 0)
			
	
			

			
