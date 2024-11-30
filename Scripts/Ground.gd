extends TileMapLayer
class_name Ground


func can_draw(maxRange: int) -> bool:
	var _canDraw: RandomNumberGenerator = RandomNumberGenerator.new()
	var _draw = _canDraw.randi_range(0, maxRange)
	
	return _draw == 0

func is_at_line(lineNumber: int, coords: Vector2) -> bool:
	return (coords.y == lineNumber or coords.x == lineNumber)
	
func has_tile_on_top(tileCoords: Vector2i) -> bool:
	var usedCells = get_used_cells()
	return usedCells.has(Vector2i(tileCoords.x, tileCoords.y - 1))
		
	
func has_tile_on_left_side(tileCoords: Vector2i) -> bool:
	var usedCells = get_used_cells()
	return usedCells.has(Vector2i(tileCoords.x - 1, tileCoords.y))
	
func get_random_bounds(boundsX: int, boundsY: int, size: int) -> Vector2i:
	var random_number: RandomNumberGenerator = RandomNumberGenerator.new()
	var heightSize = random_number.randi_range(boundsY - size, boundsY)
	var widthSize = random_number.randi_range(boundsY - size, boundsX)
	
	return Vector2(widthSize, heightSize)


func get_smalles_x_values(boundsY: int) -> Array[Vector2i]:
	var smallestXValues: Array[Vector2i]
	
	for i in boundsY:
		for value in get_used_cells():
			if value.y == i:
				if smallestXValues.size() <= i:
					smallestXValues.append(value)
				elif value.x < smallestXValues[i].x:
					smallestXValues[i] = value
	return smallestXValues

func get_smallest_y_values(boundsX: int) -> Array[Vector2i]:
	var smallestXValues: Array[Vector2i]
	
	for i in boundsX:
		for value in get_used_cells():
			if value.x == i:
				if smallestXValues.size() <= i:
					smallestXValues.append(value)
				elif value.y < smallestXValues[i].y:
					smallestXValues[i] = value
	return smallestXValues
	
func get_heighest_x_values(boundsY) -> Array[Vector2i]:
	var smallestXValues: Array[Vector2i]
	
	for i in boundsY:
		for value in get_used_cells():
			if value.y == i:
				if smallestXValues.size() <= i:
					smallestXValues.append(value)
				elif value.x > smallestXValues[i].x:
					smallestXValues[i] = value
	return smallestXValues
	
func get_heighest_y_values(boundsX: int) -> Array[Vector2i]:
	var smallestXValues: Array[Vector2i]
	
	for i in boundsX:
		for value in get_used_cells():
			if value.x == i:
				if smallestXValues.size() <= i:
					smallestXValues.append(value)
				elif value.y > smallestXValues[i].y:
					smallestXValues[i] = value
	return smallestXValues
