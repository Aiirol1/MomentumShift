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
	
	for width in bounds.x:
		for height in bounds.y:
			var randomAtlasValueX = randomNumber.randi_range(0, 1)
			var randomAtlasValueY = randomNumber.randi_range(0, 1)
			var atlasCoords: Vector2 = Vector2(randomAtlasValueX, randomAtlasValueY)
			
			var coords: Vector2 = Vector2(width, height)
			
			if isAtLine(height, width, 0): ##works
				if canDraw(2):
					set_cell(coords, 1, atlasCoords)
			elif isAtLine(height, width, 1): 
				if width == 1:
					if hasTileOnSide(coords):
						set_cell(coords, 1, atlasCoords)
					elif canDraw(1):
						set_cell(coords, 1, atlasCoords)
				if height == 1:
					if hasTileOnTop(coords):
						set_cell(coords, 1, atlasCoords)
					elif canDraw(1):
						set_cell(coords, 1, atlasCoords)
			elif  isAtLine(height, width, maxBounds - 2): ##working from here
				if canDraw(1):
					set_cell(coords, 1, atlasCoords)
			elif isAtLine(height, width, maxBounds -1):
				if width == maxBounds - 1:
					if hasTileOnSide(coords) and canDraw(1): 
						set_cell(coords, 1, atlasCoords)
				if height == maxBounds  -1:
					if hasTileOnTop(coords) and canDraw(2):
						set_cell(coords, 1, atlasCoords)
			else: set_cell(coords, 1, atlasCoords)
			
##Bug --> doesnt draw the last side where maxBounds is bigger then widht or height so if maxBounds = 25 and bounds.y = 20 then height is just a straight line
