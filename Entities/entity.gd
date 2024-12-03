extends CharacterBody2D
class_name entity

@export var resource: Resource

@onready var state_machine = %state_machine
@onready var function_component = %function_component
@onready var animation_player = %AnimationPlayer

var lives: int

func _ready():
	lives = resource.lives
	state_machine.init(self, function_component, animation_player)
	
func _unhandled_input(event):
	state_machine.process_input(event)
	
func _physics_process(delta):
	state_machine.process_physics(delta)
	
func _process(delta):
	state_machine.process_frame(delta)
