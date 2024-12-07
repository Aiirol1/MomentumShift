extends State

@export var idle: State

var changed_value = false

func enter():
	super()
	
func process_frame(_delta: float):
	if changed_value:
		return idle
	return null

func _on_player_got_hit(damage): ##maybe if player has moved and got hit then no damage
	parent.update_momentum(damage, parent.substract)
	changed_value = true
	
