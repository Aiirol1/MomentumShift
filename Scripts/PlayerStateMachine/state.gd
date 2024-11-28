extends Node
class_name State

var parent: CharacterBody2D

func enter():
	pass

func exit():
	pass
	
func process_input(event: InputEvent) -> State:
	return null
	
func process_frame(delta: float) -> State:
	return null
	
func process_physics(delta: float) -> State:
	return null


var mouse_position: Vector2

const MOUSE_DISTANCE_BUFFER = 100

func set_mouse_position():
	mouse_position = parent.get_global_mouse_position()
	
func mouse_in_near(mouse_distance_buffer: int) -> bool:
	var distance = abs(mouse_position - parent.global_position)
	return distance.length() <= mouse_distance_buffer
