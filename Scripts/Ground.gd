extends TileMapLayer
class_name Ground


func can_draw(max_range: int) -> bool:
	var _canDraw: RandomNumberGenerator = RandomNumberGenerator.new()
	var _draw = _canDraw.randi_range(0, max_range)
	
	return _draw == 0

func is_at_line(line_number: int, coords: Vector2) -> bool:
	return (coords.y == line_number or coords.x == line_number)
	
func has_tile_on_top(tile_coords: Vector2i) -> bool:
	var used_cells = get_used_cells()
	return used_cells.has(Vector2i(tile_coords.x, tile_coords.y - 1))
		
	
func has_tile_on_left_side(tile_coords: Vector2i) -> bool:
	var used_cells = get_used_cells()
	return used_cells.has(Vector2i(tile_coords.x - 1, tile_coords.y))
	
func get_random_bounds(bounds_x: int, bounds_y: int, size: int) -> Vector2i:
	var random_number: RandomNumberGenerator = RandomNumberGenerator.new()
	var height_size = random_number.randi_range(bounds_y - size, bounds_y)
	var width_size = random_number.randi_range(bounds_y - size, bounds_x)
	
	return Vector2(width_size, height_size)


func get_smalles_x_values(bounds_y: int) -> Array[Vector2i]:
	var smallest_x_values: Array[Vector2i]
	
	for i in bounds_y:
		for value in get_used_cells():
			if value.y == i:
				if smallest_x_values.size() <= i:
					smallest_x_values.append(value)
				elif value.x < smallest_x_values[i].x:
					smallest_x_values[i] = value
	return smallest_x_values

func get_smallest_y_values(bounds_x: int) -> Array[Vector2i]:
	var smallest_x_values: Array[Vector2i]
	
	for i in bounds_x:
		for value in get_used_cells():
			if value.x == i:
				if smallest_x_values.size() <= i:
					smallest_x_values.append(value)
				elif value.y < smallest_x_values[i].y:
					smallest_x_values[i] = value
	return smallest_x_values
	
func get_heighest_x_values(bounds_y) -> Array[Vector2i]:
	var smallest_x_values: Array[Vector2i]
	
	for i in bounds_y:
		for value in get_used_cells():
			if value.y == i:
				if smallest_x_values.size() <= i:
					smallest_x_values.append(value)
				elif value.x > smallest_x_values[i].x:
					smallest_x_values[i] = value
	return smallest_x_values
	
func get_heighest_y_values(bounds_x: int) -> Array[Vector2i]:
	var smallest_x_values: Array[Vector2i]
	
	for i in bounds_x:
		for value in get_used_cells():
			if value.x == i:
				if smallest_x_values.size() <= i:
					smallest_x_values.append(value)
				elif value.y > smallest_x_values[i].y:
					smallest_x_values[i] = value
	return smallest_x_values
