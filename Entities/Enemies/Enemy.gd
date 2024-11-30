extends CharacterBody2D
class_name enemy

@onready var state_machine = %state_machine
@onready var function_component = %function_component

var lives: int:
	set(value):
		lives = value

func _ready():
	state_machine.init(self, function_component)


func _process(delta):
	pass
