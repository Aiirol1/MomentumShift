extends Walls


func spawn_wall():
	set_y_cells_on_left()
	set_y_cells_on_right()

func set_y_cells_on_left():
	var y_cells: Array[Vector2i] = floor.get_left_tiles_x_values()
	
	for value in y_cells:
		if value.y > 0:
			set_cell(Vector2i(value.x, value.y), 0, Vector2i(0, 0), 0)
			if !floor.has_tile_on_left_side(value):
				set_cell(Vector2i(value.x - 1, value.y), 0, Vector2i(0, 0), 0)

			
func set_y_cells_on_right():
	var y_cells: Array[Vector2i] = floor.get_right_tiles_x_values()
	
	for value in y_cells:
		if value.y > 0:
			set_cell(Vector2i(value.x, value.y), 0, Vector2i(0, 0), 0)
			if floor.has_tile_on_left_side(value):
				set_cell(Vector2i(value.x + 1, value.y), 0, Vector2i(0, 0), 0)
			
