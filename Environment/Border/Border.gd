extends TileMapLayer
class_name Border

var floor: Ground

func draw_wall():
	spawn_wall()
	remove_if_overlapps_with_floor()
	
	for child in get_children():
		child.set_meta("bounce_strength", get_meta("bounce_strength"))
	
func spawn_wall():
	for child in get_children():
		child.floor = floor
		child.spawn_wall()
		child.remove_if_overlapps_with_floor()
	
func remove_if_overlapps_with_floor():
	var floor = floor.get_used_cells()
	var wall = get_used_cells()
	
	for i in floor:
		if wall.has(i):
			erase_cell(i)

func getFloorCells() -> Array[Vector2i]:
	var cells = get_used_cells()
	return cells
