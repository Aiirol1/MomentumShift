extends State
class_name enemy_hit

@export var move: State
@export var die: State

@onready var hit_cooldown: Timer = %Hit_cooldown
@onready var health_hud = %Health_HUD

var can_take_damage: bool = true

func enter():
	super()
	
func process_frame(_delta: float):
	if can_take_damage:
		health_hud.show()
		take_damage()
	
	var lives = parent.resource.lives
	if lives > 0:
		return move
	return die
	
func take_damage():
	parent.resource.lives -= 1
	can_take_damage = false
	hit_cooldown.start()
	parent.health_display.text = str(parent.resource.lives)
	
	var tween = get_tree().create_tween()
	
	tween.tween_property(parent.health_bar, "value", parent.resource.lives, 0.3)
	

	
func _on_hit_cooldown_timeout():
	can_take_damage = true
