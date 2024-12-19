extends Ground

func _ready():
	super()
	direction = get_random_direction()
	next_direction = direction
	set_player_starting_pos()
	draw_ground()

func set_player_starting_pos():
	if direction == directions.STRAIGHT:
		GPS.starting_pos = Vector2(50, - 50)
	elif direction == directions.DOWN:
		GPS.starting_pos = Vector2(-100, 50)
		
		
func draw_ground():
	var steps: int = get_random_steps()
	
	for step in range(steps):
		direction = next_direction
		next_direction = get_random_direction()
		if step == steps - 1: last_step = true
		
		var first_step: bool = step == 0
		if direction == directions.STRAIGHT:
			draw_straight(first_step)
		elif direction == directions.DOWN:
			draw_down(first_step)
