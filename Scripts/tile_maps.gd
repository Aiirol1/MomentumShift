extends Node2D

@onready var floor = $Floor

func _ready():
	spawnFloor()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func spawnFloor():
	var randomNumber: RandomNumberGenerator = RandomNumberGenerator.new()
	var heightSize = randomNumber.randi_range(20, 30)
	var widthSize = randomNumber.randi_range(20, 30)
	
	for width in widthSize:
		for height in heightSize:
			var randomAtlasValueX = randomNumber.randi_range(0, 1)
			var randomAtlasValueY = randomNumber.randi_range(0, 1)
			if height == 0 or width == 0:
				if canDraw():
					floor.set_cell(Vector2(width, height), 1, Vector2(randomAtlasValueX, randomAtlasValueY))
			elif height == heightSize or width == widthSize:
				if canDraw():
					floor.set_cell(Vector2(width, height), 1, Vector2(randomAtlasValueX, randomAtlasValueY))
			else:
				floor.set_cell(Vector2(width, height), 1, Vector2(randomAtlasValueX, randomAtlasValueY))


func canDraw() -> bool:
	var canDraw: RandomNumberGenerator = RandomNumberGenerator.new()
	var draw = canDraw.randi_range(0, 1)
	
	return draw == 1
