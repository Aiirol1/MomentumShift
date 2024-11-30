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
	_on_momentum_changed(-power_arrow.scale.x * MAX_CHARGING_VALUE)
	parent_component.reset_future_momentum()
	move()
	
func process_physics(delta: float):
	collision = parent.move_and_collide(parent.velocity * delta)
	bounceOff()
	handleSmoothMovement(delta)
	
	if can_change_state_to_idle():
		return idle
	return null

	
func move():
	start_pos = parent.position
	movement = getShootValues()
	power_arrow.hide()
	#firstShot = false
	#momentumChanged.emit(-powerArrow.scale.x * MAX_CHARGING_VALUE)

func getShootValues() -> Vector2:
	var newPos: Vector2
	var xPos = parent.position.x
	var yPos = parent.position.y
	newPos.x = xPos - (parent_component.charged_mouse_pos.x - xPos) * 2
	newPos.y = yPos - (parent_component.charged_mouse_pos.y - yPos) * 2
	
	return newPos
	
func handleSmoothMovement(delta):
	var totalDistance = start_pos.distance_to(movement)
	var currentDistance = parent.position.distance_to(start_pos)

	if currentDistance >= totalDistance:
		if parent.velocity.length() > FRICTION * delta:
			parent.velocity -= parent.velocity.normalized() * FRICTION * delta
		else:
			parent.velocity = Vector2.ZERO
			bouncing = false
	else:
		if !bouncing:
			parent.velocity = parent.position.direction_to(movement) * ACCELERATION
			parent.velocity = parent.velocity.limit_length(MAX_SPEED)

func bounceOff():
	if collision:
		bouncing = true
		calulateBounceOffPostition()
		
func calulateBounceOffPostition():
	var collider: Object = collision.get_collider()
	var bounceStrength: float = collider.get_meta("bounceStrength")  if (collider.has_meta("bounceStrength"))  else 1
	parent.velocity = parent.velocity.bounce(collision.get_normal()) * bounceStrength
	start_pos = parent.position

func _on_momentum_changed(value):
	value = -1 if (value > -1) else value
	
	parent.momentum += value
	var tween = get_tree().create_tween()
	tween.tween_property(parent.momentumBar, "value", parent.momentum, 0.2)

func can_change_state_to_idle() -> bool:
	return parent.velocity == Vector2.ZERO
