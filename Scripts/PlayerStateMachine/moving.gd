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

func enter():
	move()
	
func process_physics(delta: float):
	collision = parent.move_and_collide(parent.velocity * delta)
	bounceOff()
	handleSmoothMovement(delta)
	
	if parent.velocity == Vector2.ZERO :
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
	newPos.x = parent.position.x - (parent.charged_mouse_pos.x - parent.position.x) * 2
	newPos.y = parent.position.y - (parent.charged_mouse_pos.y - parent.position.y) * 2
	
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
