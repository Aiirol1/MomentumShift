extends State
class_name enemy_move

@onready var wall_detector: RayCast2D = %Wall_detector
@onready var player_detector: RayCast2D = %Player_detector
@onready var hit_area: Area2D = %Hit_area
@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D
@onready var attack_cooldown: Timer = %Attack_cooldown
@onready var invincible_cooldown: Timer = %Invincible_cooldown

@export var attack: State
@export var hit: State

var player_left_hit_area: bool = true

func process_physics(delta: float):
	parent.move_and_collide(parent.velocity * delta)
	move_direction(delta)
	change_direction()
	
	if !invincible_cooldown.is_stopped():
		parent.modulate = Color8(0, 0, 255, 255)
	
	
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
	if !hit_area.monitoring:
		return false
		
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


func _on_attack_cooldown_timeout():
	player_detector.enabled = true
	attack_cooldown.stop()


func _on_invincible_cooldown_timeout():
	parent.modulate = Color8(255, 255, 255, 255)
	collision_shape_2d.disabled = false
	hit_area.monitoring = true
	invincible_cooldown.stop()
