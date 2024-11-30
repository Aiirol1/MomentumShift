extends CharacterBody2D
class_name entity

@onready var state_machine = %state_machine
@onready var function_component = %function_component

func _ready():
	state_machine.init(self, function_component)
	
func _unhandled_input(event):
	state_machine.process_input(event)
	
func _physics_process(delta):
	state_machine.process_physics(delta)
	
func _process(delta):
	state_machine.process_frame(delta)
