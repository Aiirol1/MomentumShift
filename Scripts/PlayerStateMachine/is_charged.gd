extends State

@export var moving: State
@export var idle: State
@export var charging: State

@export var camera: Camera2D

const CAMERA_ZOOM: Vector2 = Vector2(1, 1)


func enter():
	parent.charged_mouse_pos = parent.get_global_mouse_position()
	reset_zoom()
	hide_circle()
	
func process_input(event: InputEvent):
	if Input.is_action_just_pressed("RightClick"):
		return idle
	if Input.is_action_just_pressed("Space"):
		return moving
	if Input.is_action_pressed("LeftClick") and mouse_in_near(MOUSE_DISTANCE_BUFFER):
		return charging
	return null
	
func process_frame(delta: float):
	set_mouse_position()

func hide_circle():
	parent.queue_redraw()
	parent.circle_color = Color.TRANSPARENT
	
func reset_zoom():
	var tween = get_tree().create_tween()
	tween.tween_property(camera, "zoom", CAMERA_ZOOM, 0.2)
