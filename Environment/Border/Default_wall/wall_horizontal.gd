extends Walls


func spawn_wall():
	set_x_cells_on_top()
	set_x_cells_on_ground()
	

func set_x_cells_on_top():
	var x_cells: Array[Vector2i] = floor.get_top_tiles_y_values()
	
	for value in x_cells:
		if value.x > 0:
			set_cell(Vector2i(value.x, value.y), 0, Vector2i(1, 0), 0)
			if !floor.has_tile_on_top(value):
				set_cell(Vector2(value.x, value.y - 1), 0, Vector2i(1, 0), 0)

			
func set_x_cells_on_ground():
	var x_cells: Array[Vector2i] = floor.get_ground_tiles_y_values()
	
	for value in x_cells:
		if value.x > 0:
			set_cell(Vector2i(value.x, value.y), 0, Vector2i(1, 0), 0)
			if floor.has_tile_on_top(value): ##close free gaps if gap is > 1
				set_cell(Vector2(value.x, value.y + 1 ), 0, Vector2i(1, 0), 0)
			
	
			

			
