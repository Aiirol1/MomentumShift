extends State

@export var idle: State

var changed_value = false

func enter():
	super()
	
func process_frame(_delta: float):
	if changed_value:
		return idle
	return null

func _on_player_got_hit(damage):
	parent_component._on_momentum_changed(-damage)
	changed_value = true
	
