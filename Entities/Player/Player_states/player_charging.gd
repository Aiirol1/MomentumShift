extends State

@export var is_charged: State
@export var idle: State
@export var hit: State


@export var power_arrow: Sprite2D
@export var camera: Camera2D

var circle_color = Color(Color.RED)

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
	show_future_momentum(power_arrow.scale.x * MAX_CHARGING_VALUE)
	draw_circle()
	parent.queue_redraw()
	resize_power_arrow()
	recolor_power_arrow()
	move_power_arrow()
	zoom_camera()
	
	if can_change_state_to_idle():
		return idle
	return null
	
func move_power_arrow():
	power_arrow.look_at(parent_component.mouse_position)

func recolor_power_arrow():
	power_arrow.set_self_modulate(Color8(255, 230 - int(power_arrow.scale.x * MAX_CHARGING_VALUE * 10), 0))

func resize_power_arrow():
	var distance = parent_component.mouse_position.distance_to(parent.position)
	var target_scale = distance / 20
	
	target_scale = clamp(target_scale, 0, MAX_CHARGING_VALUE)

	var tween = get_tree().create_tween()
	tween.tween_property(power_arrow, "scale:x", target_scale, 0.3)
	
func zoom_camera():
	var tween = get_tree().create_tween()
	var zoom =  Vector2(power_arrow.scale.x, power_arrow.scale.x) / 2
	zoom = clamp(zoom, CAMERA_ZOOM, CAMERA_ZOOM  * 4)
	tween.tween_property(camera, "zoom", zoom, 0.2)
	
func draw_circle():
	parent.queue_redraw()
	parent.circle_color = Color.RED ##have to call it from here _draw not working

func show_future_momentum(value: float):
	parent.future_momentum_bar.value = parent.momentum_bar.value
	parent.future_momentum = parent.future_momentum_bar.value
	parent.future_momentum_bar.show()
	
	value = 1 if (value < 1) else value ##at least 1
	parent.future_momentum_bar.value = parent.future_momentum_bar.value - int(value)
	parent.future_momentum = parent.future_momentum - value

func can_change_state_to_idle() -> bool:
	return !parent_component.mouse_in_near(parent_component.MOUSE_DISTANCE_BUFFER)
	
func can_change_state_to_is_charged() -> bool:
	return Input.is_action_just_released("left_click") and parent_component.mouse_in_near(parent_component.MOUSE_DISTANCE_BUFFER)
