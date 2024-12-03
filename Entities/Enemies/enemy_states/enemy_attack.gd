extends State
class_name enemy_attack

@export var move: State
@export var die: State

@onready var player_detector: RayCast2D = %Player_detector
@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D
@onready var attack_cooldown: Timer = %Attack_cooldown
@onready var invincible_cooldown: Timer = %Invincible_cooldown
@onready var hit_area: Area2D = %Hit_area

func process_frame(_delta: float):
	collision_shape_2d.disabled = true
	player_detector.enabled = false
	hit_area.monitoring = false
	attack_cooldown.start()
	invincible_cooldown.start()
	return move
