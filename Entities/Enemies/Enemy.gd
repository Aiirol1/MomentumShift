extends entity
class_name enemy

var speed: int

@onready var attack_cooldown: Timer = %Attack_cooldown
@onready var invincible_cooldown: Timer = %Invincible_cooldown
@onready var health_hud = %Health_HUD

func _ready():
	super()
	speed = resource.speed
	attack_cooldown.wait_time = resource.attack_cooldown
	invincible_cooldown.wait_time = resource.invincible_cooldown
	health_hud.init(resource)
	
	
	
