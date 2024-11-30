extends Node
class_name State

var parent: CharacterBody2D
var parent_component: Node

func enter():
	pass

func exit():
	pass
	
func process_input(_event: InputEvent) -> State:
	return null
	
func process_frame(_delta: float) -> State:
	return null
	
func process_physics(_delta: float) -> State:
	return null
