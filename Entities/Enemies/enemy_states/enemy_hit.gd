extends State
class_name enemy_hit

@export var move: State
@export var die: State

@onready var hit_cooldown: Timer = %Hit_cooldown

var can_take_damage: bool = true

func enter():
	super()
	
func process_frame(_delta: float):
	if can_take_damage:
		take_damage()
	
	var lives = parent.resource.lives
	if lives > 0:
		return move
	return die
	
func take_damage():
	parent.resource.lives -= 1
	can_take_damage = false
	hit_cooldown.start()
	
func _on_hit_cooldown_timeout():
	can_take_damage = true
