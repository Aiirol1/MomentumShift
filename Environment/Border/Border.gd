extends TileMapLayer
class_name Walls


@export var floor: TileMapLayer

func _ready():
	spawn_wall()
	
	for child in get_children():
		child.set_meta("bounce_strength", get_meta("bounce_strength"))
	
func spawn_wall():
	pass

func getFloorCells() -> Array[Vector2i]:
	var cells = get_used_cells()
	return cells
