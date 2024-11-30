extends TileMapLayer
class_name Walls


@export var floor: TileMapLayer

func _ready():
	spawn_wall()
	
func spawn_wall():
	pass

func getFloorCells() -> Array[Vector2i]:
	var cells = get_used_cells()
	return cells
