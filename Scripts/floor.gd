extends TileMaps


func _ready():
	spawnFloor()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func spawnFloor():
	var randomNumber: RandomNumberGenerator = RandomNumberGenerator.new()
	var bounds = getRandomBounds(30, 30, 10)
	var maxBounds = max(bounds.x, bounds.y)
	var minBounds = min(bounds.x, bounds.y)
	
	print(bounds.x, " ", bounds.y)
	
	for width in bounds.x:
		for height in bounds.y:
			var randomAtlasValueX = randomNumber.randi_range(0, 1)
			var randomAtlasValueY = randomNumber.randi_range(0, 1)
			var atlasCoords: Vector2 = Vector2(randomAtlasValueX, randomAtlasValueY)
			
			var coords: Vector2 = Vector2(width, height)
			
			if isAtLine(coords, 0): ##works
				if canDraw(2):
					set_cell(coords, 1, atlasCoords)
			elif isAtLine(coords, 1): 
				if width == 1:
					if hasTileOnLeftSide(coords):
						set_cell(coords, 1, atlasCoords)
					elif canDraw(1):
						set_cell(coords, 1, atlasCoords)
				if height == 1:
					if hasTileOnTop(coords):
						set_cell(coords, 1, atlasCoords)
					elif canDraw(1):
						set_cell(coords, 1, atlasCoords)
			elif  isAtLine(coords, maxBounds - 2): 
				if canDraw(1):
					set_cell(coords, 1, atlasCoords)
			elif isAtLine(coords, minBounds - 1):
				if bounds.x == minBounds:
					if width == minBounds - 1:
						if hasTileOnLeftSide(coords) and canDraw(1): 
							set_cell(Vector2i(minBounds, coords.y), 1, atlasCoords)
				elif bounds.x == maxBounds:
					set_cell(coords, 1, atlasCoords)
				if bounds.y == minBounds:
					if height == minBounds - 1:
						if hasTileOnTop(coords) and canDraw(2):
							set_cell(Vector2i(coords.x, minBounds), 1, atlasCoords)
				elif bounds.y == maxBounds:
					set_cell(coords, 1, atlasCoords)
			elif  isAtLine(coords, maxBounds - 1):
				if bounds.x == maxBounds:
					if width == maxBounds - 1:
						if hasTileOnLeftSide(coords) and canDraw(1): 
							set_cell(coords, 1, atlasCoords)
				if bounds.y == maxBounds:
					if height == maxBounds -1:
						if hasTileOnTop(coords) and canDraw(2):
							set_cell(coords, 1, atlasCoords)
			else: set_cell(coords, 1, atlasCoords)
