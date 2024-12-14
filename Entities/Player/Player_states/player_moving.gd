extends State
class_name Player_moving

@export var idle: State


@export var power_arrow: Sprite2D

var collision: KinematicCollision2D

const FRICTION: int = 700
const MIN_SPEED: int = 600
const MAX_SPEED: int = 1000
const MAX_DISTANCE: int = 500
const MAX_CHARGING_VALUE: int = 4


func enter():
	parent.update_momentum(power_arrow.scale.x * MAX_CHARGING_VALUE, parent.substract, "Input")
	parent.reset_future_momentum()

	move()
	
func process_physics(delta: float):
	if parent.velocity.length() > 0:
		collision = parent.move_and_collide(parent.velocity * delta)
		if collision:
			bounce_off()
		handle_smooth_movement(delta)
	
	if can_change_state_to_idle():
		return idle
	return null

	
func move():
	parent.velocity = get_shoot_values()
	power_arrow.hide()

func get_shoot_values() -> Vector2:
	var player_pos = parent.global_position
	var distance = player_pos.distance_to(parent.charged_mouse_pos)
	distance = clamp(distance, 0, MAX_DISTANCE)
	var charge_factor = 1 - exp(-3 * (distance / MAX_DISTANCE))
	var shoot_speed = lerp(MIN_SPEED, MAX_SPEED, charge_factor)
	var shoot_direction = (player_pos - parent.charged_mouse_pos).normalized()
	return shoot_direction * shoot_speed
	
func handle_smooth_movement(delta: float):
	parent.velocity = parent.velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
func bounce_off():
	if collision:
		var collider = collision.get_collider()
		var bounce_strength = collider.get_meta("bounce_strength") if collider.has_meta("bounce_strength") else 1.0
		var incoming_velocity = parent.velocity
		var reflected_velocity = incoming_velocity.bounce(collision.get_normal())
		
		parent.velocity = reflected_velocity * bounce_strength
		

func can_change_state_to_idle() -> bool:
	return parent.velocity == Vector2.ZERO

func exit():
	GPS.last_state = self
