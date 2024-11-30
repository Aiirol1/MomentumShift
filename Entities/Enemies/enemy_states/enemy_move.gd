extends State
class_name enemy_move

@onready var wall_detector = %Wall_detector

func process_physics(delta: float):
	parent.move_and_slide()
	move_direction(delta)
	change_direction()


func move_direction(delta: float):
	parent.velocity.y = wall_detector.target_position.y * parent.speed * delta

func change_direction():
	if wall_detector.is_colliding():
		wall_detector.target_position *= -1
