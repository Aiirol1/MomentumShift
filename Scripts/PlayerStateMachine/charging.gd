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
	
func process_input(_event: InputEvent):
	if can_change_state_to_is_charged():
		return is_charged
	return null
		
func process_physics(_delta: float):
	parent_component.set_mouse_position()
	showFutureMomentum(power_arrow.scale.x * MAX_CHARGING_VALUE)
	draw_circle()
	parent.queue_redraw()
	resizePowerArrow()
	recolorPowerArrow()
	movePowerArrow()
	zoomCamera()
	
	if can_change_state_to_idle():
		return idle
	return null
	
func movePowerArrow():
	power_arrow.look_at(parent_component.mouse_position)

func recolorPowerArrow():
	power_arrow.set_self_modulate(Color8(255, 230 - int(power_arrow.scale.x * MAX_CHARGING_VALUE * 10), 0))

func resizePowerArrow():
	var distance = parent_component.mouse_position.distance_to(parent.position)
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

func showFutureMomentum(value: float):
	parent.futureMomentumBar.value = parent.momentumBar.value
	parent.futureMomentum = parent.futureMomentumBar.value
	parent.futureMomentumBar.show()
	
	value = 1 if (value < 1) else value
	parent.futureMomentumBar.value = parent.futureMomentumBar.value - int(value)
	parent.futureMomentum = parent.futureMomentum - value

func can_change_state_to_idle() -> bool:
	return !parent_component.mouse_in_near(parent_component.MOUSE_DISTANCE_BUFFER)
	
func can_change_state_to_is_charged() -> bool:
	return Input.is_action_just_released("LeftClick") and parent_component.mouse_in_near(parent_component.MOUSE_DISTANCE_BUFFER)
