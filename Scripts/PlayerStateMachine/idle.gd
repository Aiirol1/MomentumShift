extends State

@export var charging: State

@export var powerArrow: Sprite2D
@export var camera: Camera2D

const CAMERA_ZOOM: Vector2 = Vector2(1, 1)

func enter():
	resetZoom()
	hide_circle()
	powerArrow.hide()

func process_input(event: InputEvent):
	if Input.is_action_pressed("LeftClick") and mouse_in_near(MOUSE_DISTANCE_BUFFER):
		return charging
	return null
	
func process_frame(delta: float):
	set_mouse_position()
	return null
	
func resetZoom():
	var tween = get_tree().create_tween()
	tween.tween_property(camera, "zoom", CAMERA_ZOOM, 0.2)

func hide_circle():
	parent.circle_color = Color.TRANSPARENT
	parent.queue_redraw()
