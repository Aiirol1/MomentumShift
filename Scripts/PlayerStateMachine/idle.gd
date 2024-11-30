extends State

@export var charging: State

@export var power_arrow: Sprite2D

func enter():
	parent_component.reset_zoom()
	parent_component.hide_circle()
	parent_component.reset_future_momentum()
	power_arrow.hide()

func process_input(_event: InputEvent):
	if can_change_state_to_charging():
		return charging
	return null
	
func process_frame(_delta: float):
	parent_component.set_mouse_position()
	return null
	
func can_change_state_to_charging() -> bool:
	return Input.is_action_pressed("left_click") and parent_component.mouse_in_near(parent_component.MOUSE_DISTANCE_BUFFER) and parent.momentum > 0
