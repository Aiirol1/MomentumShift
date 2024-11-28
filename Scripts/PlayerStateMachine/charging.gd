extends State

@export var is_charged: State
@export var idle: State

@export var power_arrow: Sprite2D
@export var camera: Camera2D

var circleColor = Color(Color.RED)

const MAX_CHARGING_VALUE: int = 4
const CAMERA_ZOOM: Vector2 = Vector2(1, 1)

func enter():
	power_arrow.show()
	
func process_input(event: InputEvent):
	if !mouse_in_near(MOUSE_DISTANCE_BUFFER):
		return idle
	if Input.is_action_just_released("LeftClick") and mouse_in_near(MOUSE_DISTANCE_BUFFER):
		return is_charged
	return null
		
func process_physics(delta: float):
	set_mouse_position()
	draw_circle()
	parent.queue_redraw()
	resizePowerArrow()
	recolorPowerArrow()
	movePowerArrow()
	zoomCamera()
	
	
func movePowerArrow():
	power_arrow.look_at(mouse_position)

func recolorPowerArrow():
	power_arrow.set_self_modulate(Color8(255, 230 - int(power_arrow.scale.x * MAX_CHARGING_VALUE * 10), 0))

func resizePowerArrow():
	var distance = mouse_position.distance_to(parent.position)
	var target_scale = distance / 20
	
	target_scale = clamp(target_scale, 0, MAX_CHARGING_VALUE)

	var tween = get_tree().create_tween()
	tween.tween_property(power_arrow, "scale:x", target_scale, 0.3)
	
func zoomCamera():
	var tween = get_tree().create_tween()
	var zoom =  Vector2(power_arrow.scale.x, power_arrow.scale.x) / 2
	zoom = clamp(zoom, CAMERA_ZOOM, CAMERA_ZOOM  * 4)
	tween.tween_property(camera, "zoom", zoom, 0.2)
	
func draw_circle():
	parent.queue_redraw()
	parent.circle_color = Color.RED ##have to call it from here _draw not working
