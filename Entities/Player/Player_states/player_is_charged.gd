extends State

@export var moving: State
@export var idle: State
@export var charging: State
@export var hit: State



func enter():
	parent.charged_mouse_pos = parent.get_mouse_position()
	parent.reset_zoom()
	parent.hide_circle()
	
func process_input(_event: InputEvent):
	if can_change_state_to_idle():
		return idle
	if can_change_state_to_moving():
		return moving
	if can_change_state_to_charging():
		return charging
	return null
	
func process_frame(_delta: float):
	parent.set_mouse_position()

func can_change_state_to_idle() -> bool:
	return Input.is_action_just_pressed("right_click")
	
func can_change_state_to_moving() -> bool:
	return Input.is_action_just_pressed("Space") and (parent.future_momentum >= 0 or parent.effect_resource.no_momentum_use_active()) 
	
func can_change_state_to_charging() -> bool:
	return Input.is_action_pressed("left_click") and parent.mouse_in_near(parent.MOUSE_DISTANCE_BUFFER)

func exit():
	GPS.last_state = self
