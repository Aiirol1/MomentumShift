extends State
class_name player_hit

@export var idle: State

var changed_value = false

func enter():
	super()
	
func process_frame(_delta: float):
	if changed_value:
		return idle
	return null

func _on_player_got_hit(damage):
	parent.update_momentum(damage, parent.substract)
	changed_value = true
	
func exit():
	GPS.last_state = self
	
