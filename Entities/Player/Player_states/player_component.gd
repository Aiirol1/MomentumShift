extends Node

##contains functions that are getting called in multiple states but have the same behavior

var mouse_position: Vector2
var charged_mouse_pos: Vector2

@export var parent: CharacterBody2D
@export var camera: Camera2D

const MOUSE_DISTANCE_BUFFER = 100
const CAMERA_ZOOM: Vector2 = Vector2(1, 1)

func set_mouse_position():
	mouse_position = parent.get_global_mouse_position()
	
func get_mouse_position() -> Vector2:
	return parent.get_global_mouse_position()
	
func mouse_in_near(mouse_distance_buffer: int) -> bool:
	var distance = abs(mouse_position - parent.global_position)
	return distance.length() <= mouse_distance_buffer
	
func reset_zoom():
	var tween = get_tree().create_tween()
	tween.tween_property(camera, "zoom", CAMERA_ZOOM, 0.2)

func hide_circle():
	parent.circle_color = Color.TRANSPARENT
	parent.queue_redraw()

func reset_future_momentum():
	var tween = get_tree().create_tween()
	tween.tween_property(parent.future_momentum_bar, "value", parent.momentum, 0.3)
	tween.finished.connect(tween_finished)
	
func tween_finished():
	parent.future_momentum_bar.hide()

func _on_momentum_changed(value):
	value = -1 if (value > -1) else value
	
	parent.momentum += value
	var tween = get_tree().create_tween()
	tween.tween_property(parent.momentum_bar, "value", parent.momentum, 0.2)
