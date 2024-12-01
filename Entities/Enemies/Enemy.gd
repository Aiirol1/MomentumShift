extends entity
class_name enemy

var speed: int

func _ready():
	super()
	speed = resource.speed
