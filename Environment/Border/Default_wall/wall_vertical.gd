extends Border


func spawn_wall():
	draw_inner_tiles()
	draw_outer_tiles()

func draw_inner_tiles():
	var inner_tiles: Array[Vector2] = floor.inner_tiles_down
	
	for cell in inner_tiles:
		set_cell(Vector2(cell.x - 1, cell.y), 0, Vector2i(0, 0), 0)

func draw_outer_tiles():
	var outer_tiles: Array[Vector2] = floor.outer_tiles_down
	
	for cell in outer_tiles:
		set_cell(Vector2(cell.x + 1, cell.y), 0, Vector2i(0, 0), 0)
