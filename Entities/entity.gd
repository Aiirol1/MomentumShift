extends CharacterBody2D
class_name entity

@export var resource: Resource

@onready var state_machine = %state_machine
@onready var animation_player = %AnimationPlayer

var lives: int

func _ready():
	lives = resource.lives
	state_machine.init(self, animation_player)
	
func _unhandled_input(event):
	state_machine.process_input(event)
	
func _physics_process(delta):
	state_machine.process_physics(delta)
	
func _process(delta):
	state_machine.process_frame(delta)
