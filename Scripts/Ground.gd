extends TileMapLayer
class_name Ground


func canDraw(maxRange: int) -> bool:
	var _canDraw: RandomNumberGenerator = RandomNumberGenerator.new()
	var _draw = _canDraw.randi_range(0, maxRange)
	
	return _draw == 0

func isAtLine(lineNumber: int, coords: Vector2) -> bool:
	return (coords.y == lineNumber or coords.x == lineNumber)
	
func hasTileOnTop(tileCoords: Vector2i) -> bool:
	var usedCells = get_used_cells()
	return usedCells.has(Vector2i(tileCoords.x, tileCoords.y - 1))
		
	
func hasTileOnLeftSide(tileCoords: Vector2i) -> bool:
	var usedCells = get_used_cells()
	return usedCells.has(Vector2i(tileCoords.x - 1, tileCoords.y))
	
func getRandomBounds(boundsX: int, boundsY: int, size: int) -> Vector2i:
	var randomNumber: RandomNumberGenerator = RandomNumberGenerator.new()
	var heightSize = randomNumber.randi_range(boundsY - size, boundsY)
	var widthSize = randomNumber.randi_range(boundsY - size, boundsX)
	
	return Vector2(widthSize, heightSize)


func getSmallestXValues(boundsY: int) -> Array[Vector2i]:
	var smallestXValues: Array[Vector2i]
	
	for i in boundsY:
		for value in get_used_cells():
			if value.y == i:
				if smallestXValues.size() <= i:
					smallestXValues.append(value)
				elif value.x < smallestXValues[i].x:
					smallestXValues[i] = value
	return smallestXValues

func getSmallestYValues(boundsX: int) -> Array[Vector2i]:
	var smallestXValues: Array[Vector2i]
	
	for i in boundsX:
		for value in get_used_cells():
			if value.x == i:
				if smallestXValues.size() <= i:
					smallestXValues.append(value)
				elif value.y < smallestXValues[i].y:
					smallestXValues[i] = value
	return smallestXValues
	
func getHighestXValues(boundsY) -> Array[Vector2i]:
	var smallestXValues: Array[Vector2i]
	
	for i in boundsY:
		for value in get_used_cells():
			if value.y == i:
				if smallestXValues.size() <= i:
					smallestXValues.append(value)
				elif value.x > smallestXValues[i].x:
					smallestXValues[i] = value
	return smallestXValues
	
func getHighestYValues(boundsX: int) -> Array[Vector2i]:
	var smallestXValues: Array[Vector2i]
	
	for i in boundsX:
		for value in get_used_cells():
			if value.x == i:
				if smallestXValues.size() <= i:
					smallestXValues.append(value)
				elif value.y > smallestXValues[i].y:
					smallestXValues[i] = value
	return smallestXValues
