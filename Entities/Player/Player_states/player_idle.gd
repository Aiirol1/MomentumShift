extends State

@export var charging: State
@export var hit: State

@export var power_arrow: Sprite2D


func enter():
	parent.reset_effects()
	parent.reset_zoom()
	parent.hide_circle()
	parent.reset_future_momentum()
	power_arrow.hide()

func process_input(_event: InputEvent):
	if can_change_state_to_charging():
		return charging
	return null
	
func process_frame(_delta: float):
	parent.set_mouse_position()
	return null
	
func can_change_state_to_charging() -> bool:
	return Input.is_action_pressed("left_click") and parent.mouse_in_near(parent.MOUSE_DISTANCE_BUFFER) and parent.momentum > 0
