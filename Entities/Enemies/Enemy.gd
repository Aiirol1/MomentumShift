extends entity
class_name enemy

var speed: int

@onready var attack_cooldown: Timer = %Attack_cooldown
@onready var invincible_cooldown: Timer = %Invincible_cooldown
@onready var health_bar: ProgressBar = %Health_bar
@onready var health_display: Label = %Health_display
@onready var health_hud = %Health_HUD

func _ready():
	super()
	health_hud.hide()
	speed = resource.speed
	attack_cooldown.wait_time = resource.attack_cooldown
	invincible_cooldown.wait_time = resource.invincible_cooldown
	
	health_bar.max_value = resource.lives
	health_bar.value = health_bar.max_value
	health_display.text = str(resource.lives)
	
	
