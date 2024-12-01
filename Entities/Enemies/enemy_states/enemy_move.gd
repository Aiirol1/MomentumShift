extends State
class_name enemy_move

@onready var wall_detector: RayCast2D = %Wall_detector
@onready var player_detector: RayCast2D = %Player_detector
@onready var hit_area: Area2D = %Hit_area

@export var attack: State
@export var hit: State

var player_left_hit_area: bool = true

func process_physics(delta: float):
	parent.move_and_slide()
	move_direction(delta)
	change_direction()
	
	if collides_with_player():
		return attack
	if get_attacked_by_player():
		return hit
	return null

func move_direction(delta: float):
	parent.velocity.y = wall_detector.target_position.y * parent.speed * delta

func change_direction():
	if wall_detector.is_colliding():
		wall_detector.target_position *= -1
		player_detector.target_position *= -1
		
func collides_with_player() -> bool:
	if player_detector.is_colliding():
		var collider = player_detector.get_collider()
		if collider is Player:
			collider.emit_signal("got_hit", parent.resource.damage)
			return true
	return false
		
func get_attacked_by_player() -> bool:
	if hit_area.has_overlapping_bodies() and player_left_hit_area:
		var colliders = hit_area.get_overlapping_bodies()
		for obj in colliders:
			if obj is Player:
				player_left_hit_area = false
				return true
	return false


func _on_hit_area_body_exited(body):
	if body is Player:
		player_left_hit_area = true
