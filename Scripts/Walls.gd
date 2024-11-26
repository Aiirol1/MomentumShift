extends TileMapLayer
class_name Walls

@export var floor: TileMapLayer

func _ready():
	spawnWall()
	
func spawnWall():
	pass

func getFloorCells() -> Array[Vector2i]:
	var cells = get_used_cells()
	return cells
