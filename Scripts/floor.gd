extends Ground

var _minBounds
var _maxBounds
var bounds


func _ready():
	spawnFloor()

func spawnFloor():
	var randomNumber: RandomNumberGenerator = RandomNumberGenerator.new()
	bounds = getRandomBounds(30, 30, 10)
	_maxBounds = max(bounds.x, bounds.y)
	_minBounds = min(bounds.x, bounds.y)
	
	for width in bounds.x:
		for height in bounds.y:
			var randomAtlasValueX = randomNumber.randi_range(0, 1)
			var randomAtlasValueY = randomNumber.randi_range(0, 1)
			var atlasCoords: Vector2 = Vector2(randomAtlasValueX, randomAtlasValueY)
			var coords: Vector2 = Vector2(width, height)
			
			if isAtLine(0, coords): ##first line
				if canDraw(2): ##--> 33% to draw cell (1 is 50%)
					set_cell(coords, 1, atlasCoords)
					
			elif isAtLine(1, coords):  ##second line
				drawWidthSecondLine(coords, atlasCoords)
				drawHeightSecondLine(coords, atlasCoords)
				
			elif isAtLine(_maxBounds-2, coords): ## second outer line 
				if canDraw(1):
					set_cell(coords, 1, atlasCoords)
					
			elif isAtLine(_minBounds-1, coords):
				LastLineOnMinValue(coords, atlasCoords)
					
			elif isAtLine(_maxBounds-1, coords):
				lastLine(coords, atlasCoords)
					
			else: set_cell(coords, 1, atlasCoords) ##is on other line just draw the cell


func drawWidthSecondLine(coords: Vector2i, atlasCoords: Vector2i):
	if coords.x == 1:
		if hasTileOnLeftSide(coords):
			set_cell(coords, 1, atlasCoords)
		elif canDraw(1):
			set_cell(coords, 1, atlasCoords)
			
func drawHeightSecondLine(coords: Vector2i, atlasCoords: Vector2i):
	if coords.y == 1:
		if hasTileOnTop(coords):
			set_cell(coords, 1, atlasCoords)
		elif canDraw(1):
			set_cell(coords, 1, atlasCoords)
			
func drawWidthSecondOuterLine(coords: Vector2i, atlasCoords: Vector2i):
	if coords.x == _minBounds - 1:
		if hasTileOnLeftSide(coords) and canDraw(1): 
			set_cell(Vector2i(_minBounds, coords.y), 1, atlasCoords)
	elif bounds.x == _maxBounds:
		set_cell(coords, 1, atlasCoords)
		
func drawHeightSecondOuterLine(coords: Vector2i, atlasCoords: Vector2i):
	if coords.y == _minBounds - 1:
			if hasTileOnTop(coords) and canDraw(2):
				set_cell(Vector2i(coords.x, _minBounds), 1, atlasCoords)

		
func drawWidthOuterLine(coords: Vector2i, atlasCoords: Vector2i):
	if coords.x == _maxBounds - 1:
		if hasTileOnLeftSide(coords) and canDraw(1): 
			set_cell(coords, 1, atlasCoords)
			
func drawHeightOuterLine(coords: Vector2i, atlasCoords: Vector2i):
	if coords.y == _maxBounds -1:
		if hasTileOnTop(coords) and canDraw(2):
			set_cell(coords, 1, atlasCoords)
			
func LastLineOnMinValue(coords: Vector2i, atlasCoords: Vector2i):
	if isMinBounds(bounds.x):
		drawWidthSecondOuterLine(coords, atlasCoords)
	elif isMaxBounds(bounds.x):
		set_cell(coords, 1, atlasCoords)
		
	if isMinBounds(bounds.y):
		drawHeightSecondOuterLine(coords, atlasCoords)
	elif isMaxBounds(bounds.y):
		set_cell(coords, 1, atlasCoords)
		
func lastLine(coords: Vector2i, atlasCoords: Vector2i):
	if isMaxBounds(coords.x):
		drawWidthOuterLine(coords, atlasCoords)
	if isMaxBounds(coords.x):
		drawHeightOuterLine(coords, atlasCoords)
		
func getLeftTilesXValues() -> Array[Vector2i]:
	return getSmallestXValues(bounds.y)
	
func getTopTilesYValues() -> Array[Vector2i]:
	return getSmallestYValues(bounds.x)
	
func getRightTilesXValues() -> Array[Vector2i]:
	return getHighestXValues(bounds.y)
	
func getGroundTilesYValues() -> Array[Vector2i]:
	return getHighestYValues(bounds.x)

func isMinBounds(value: int) -> bool:
	return value == _minBounds
	
func isMaxBounds(value: int) -> bool:
	return value == _maxBounds
	
