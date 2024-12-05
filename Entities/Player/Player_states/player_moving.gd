extends State

@export var idle: State


@export var power_arrow: Sprite2D

var start_pos: Vector2
var movement: Vector2
var bouncing: bool = false
var collision: KinematicCollision2D

const FRICTION: int = 1000
const MAX_SPEED: int = 800
const ACCELERATION: int = 500
const MAX_CHARGING_VALUE: int = 4


func enter():
	parent.update_momentum(power_arrow.scale.x * MAX_CHARGING_VALUE, parent.substract_momentum)
	parent.reset_future_momentum()

	move()
	
func process_physics(delta: float):
	collision = parent.move_and_collide(parent.velocity * delta)
	bounce_off()
	handle_smooth_movement(delta)
	
	if can_change_state_to_idle():
		return idle
	return null

	
func move():
	start_pos = parent.position
	movement = get_shoot_values()
	power_arrow.hide()

func get_shoot_values() -> Vector2:
	var newPos: Vector2
	var x_pos = parent.position.x
	var y_pos = parent.position.y
	newPos.x = x_pos - (parent.charged_mouse_pos.x - x_pos) * 2
	newPos.y = y_pos - (parent.charged_mouse_pos.y - y_pos) * 2
	
	return newPos
	
func handle_smooth_movement(delta):
	var total_distance = start_pos.distance_to(movement)
	var current_distance = parent.position.distance_to(start_pos)

	if current_distance >= total_distance:
		if parent.velocity.length() > FRICTION * delta:
			parent.velocity -= parent.velocity.normalized() * FRICTION * delta
		else:
			parent.velocity = Vector2.ZERO
			bouncing = false
	else:
		if !bouncing:
			parent.velocity = parent.position.direction_to(movement) * ACCELERATION
			parent.velocity = parent.velocity.limit_length(MAX_SPEED)

func bounce_off():
	if collision:
		bouncing = true
		calculate_bounce_off_position()
		
func calculate_bounce_off_position():
	var collider: Object = collision.get_collider()
	var bounce_strength: float = collider.get_meta("bounce_strength")  if (collider.has_meta("bounce_strength"))  else 1
	parent.velocity = parent.velocity.bounce(collision.get_normal()) * bounce_strength
	start_pos = parent.position

func can_change_state_to_idle() -> bool:
	return parent.velocity == Vector2.ZERO
