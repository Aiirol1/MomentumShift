extends CharacterBody2D

var mousePosition: Vector2
var startPos: Vector2
var movement: Vector2
var firstShot: bool = true
var charged: bool = false
var collision: KinematicCollision2D
var bouncing: bool = false
var shooting: bool = false
var circleColor: Color = Color.TRANSPARENT


var momentum: float = 100
var futureMomentum: float = 100


const MOUSE_DISTANCE_BUFFER: int = 100
const FRICTION: int = 1000
const MAX_SPEED: int = 800
const ACCELERATION: int = 500
const MAX_MOMENTUM: int = 100
const MAX_CHARGING_VALUE: int = 4

const CAMERA_ZOOM = Vector2(1, 1)


@export var momentumBar: ProgressBar
@export var futureMomentumBar: ProgressBar

@onready var powerArrow: Sprite2D = $PowerArrow
@onready var camera: Camera2D = $Camera2D

signal momentumChanged(value)


func _ready():
	initMomentumBars()


func _physics_process(delta):
	input()
	bounceOff()
	getMousePosition()
	handleSmoothMovement(delta)
	
	collision = move_and_collide(velocity * delta)
	

func input():
	if canCharge():
		if Input.is_action_pressed("LeftClick"):
			drawCircle()
			chargeArrow()
		if Input.is_action_just_released("LeftClick"):
			charged = true
			hideCircle()
			resetZoom()

	else:
		if !charged:
			hideCircle()
			resetZoom()
			resetFutureMomentum()
			powerArrow.hide()
		
	if Input.is_action_just_pressed("RightClick"):
		charged = false
		resetFutureMomentum()
		powerArrow.hide()
		
	if canShoot():
		shooting = true
		shoot()
		
func canShoot() -> bool:
	return charged and Input.is_action_just_pressed("Space") and enoughMomentum() and enoughFutureMomentum()
		
func canCharge() -> bool:
	return mouseInNear() && !shooting
	
func enoughMomentum() -> bool:
	return momentum > 0 
	
func enoughFutureMomentum() -> bool:
	return futureMomentum >= -1
	
func shoot(): 
	startPos = self.position
	movement = getShootValues()
	firstShot = false
	powerArrow.hide()
	charged = false
	momentumChanged.emit(-powerArrow.scale.x * MAX_CHARGING_VALUE)
	

func chargeArrow():
	powerArrow.show()
	movePowerArrow()
	resizePowerArrow()
	recolorPowerArrow()
	zoomCamera()
	showFutureMomentum(powerArrow.scale.x * MAX_CHARGING_VALUE)


func bounceOff():
	if collision:
		bouncing = true
		shooting = false
		calulateBounceOffPostition()
		
func calulateBounceOffPostition():
	var collider: Object = collision.get_collider()
	var bounceStrength: float = collider.get_meta("bounceStrength")  if (collider.has_meta("bounceStrength"))  else 1
	velocity = velocity.bounce(collision.get_normal()) * bounceStrength
	startPos = self.position
	
func getShootValues() -> Vector2:
	var newPos: Vector2
	newPos.x = self.position.x - (mousePosition.x - self.position.x) * 2
	newPos.y = self.position.y - (mousePosition.y - self.position.y) * 2
	
	return newPos
	
func handleSmoothMovement(delta):
	var totalDistance = startPos.distance_to(movement)
	var currentDistance = self.position.distance_to(startPos)

	if currentDistance >= totalDistance:
		if velocity.length() > FRICTION * delta:
			velocity -= velocity.normalized() * FRICTION * delta
		else:
			velocity = Vector2.ZERO
			shooting = false
			bouncing = false
	else:
		if !firstShot && !bouncing:
			velocity = position.direction_to(movement) * ACCELERATION
			velocity = velocity.limit_length(MAX_SPEED)
			
func showFutureMomentum(value: float):
	futureMomentumBar.value = momentumBar.value
	futureMomentum = futureMomentumBar.value
	futureMomentumBar.show()
	
	value = 1 if (value < 1) else value
	futureMomentumBar.value = futureMomentumBar.value - int(value)
	futureMomentum = futureMomentum - value
	
func resetFutureMomentum():
	var tween = get_tree().create_tween()
	tween.tween_property(futureMomentumBar, "value", momentumBar.value, 0.3)
	tween.finished.connect(tweenFinished)
	
func initMomentumBars():
	momentumBar.max_value = MAX_MOMENTUM
	momentumBar.value = MAX_MOMENTUM
	futureMomentumBar.max_value = MAX_MOMENTUM
	futureMomentumBar.value = MAX_MOMENTUM
	futureMomentumBar.hide()
	
func getMousePosition():
	mousePosition = get_global_mouse_position()

func movePowerArrow():
	powerArrow.look_at(mousePosition)
	
func recolorPowerArrow():
	powerArrow.set_self_modulate(Color8(255, 230 - int(powerArrow.scale.x * MAX_CHARGING_VALUE * 10), 0))
	
func resizePowerArrow():
	var distance = mousePosition.distance_to(self.position)
	var target_scale = distance / 20
	
	target_scale = clamp(target_scale, 0, MAX_CHARGING_VALUE)

	var tween = get_tree().create_tween()
	tween.tween_property(powerArrow, "scale:x", target_scale, 0.3)
	
func zoomCamera():
	var tween = get_tree().create_tween()
	var zoom =  Vector2(powerArrow.scale.x, powerArrow.scale.x) / 2
	zoom = clamp(zoom, CAMERA_ZOOM, CAMERA_ZOOM  * 4)
	tween.tween_property(camera, "zoom", zoom, 0.2)
	
func resetZoom():
	var tween = get_tree().create_tween()
	tween.tween_property(camera, "zoom", CAMERA_ZOOM, 0.2)
	
func mouseInNear() -> bool:
	var distance = abs(mousePosition - self.position)
	
	return distance.length() <= MOUSE_DISTANCE_BUFFER

func tweenFinished():
	futureMomentumBar.hide()
	
func drawCircle():
	circleColor = Color.RED
	queue_redraw()
	
func hideCircle():
	circleColor = Color.TRANSPARENT
	queue_redraw()
	
func _draw():
	var local_position = to_local(self.global_position)
	draw_circle(local_position, MOUSE_DISTANCE_BUFFER, circleColor, false, 1, true)

func _on_momentum_changed(value):
	value = -1 if (value > -1) else value
	
	momentum += value
	var tween = get_tree().create_tween()
	tween.tween_property(momentumBar, "value", momentum, 0.2)
	
	futureMomentumBar.hide()
