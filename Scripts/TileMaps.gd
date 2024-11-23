extends TileMapLayer
class_name TileMaps

func canDraw(maxRange: int) -> bool:
	var _canDraw: RandomNumberGenerator = RandomNumberGenerator.new()
	var _draw = _canDraw.randi_range(0, maxRange)
	
	return _draw == 0

func isAtLine(lineNumber: int, coords: Vector2) -> bool:
	var lineNumberEnd = lineNumber + 1
	
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
