extends StaticBody2D
class_name Obstacle

var collision: KinematicCollision2D
var start_lives: int

@export var resource: Obstacle_resource

@onready var sprite_2d = %Sprite2D
@onready var animation_player = %AnimationPlayer


func _ready():
	resource = resource.duplicate()
	start_lives = resource.lives
	sprite_2d.frame = 0

		
func destroy():
	if !resource.lives <= 0:
		return
		
	if animation_player.has_animation("destroy"):
		animation_player.play("destroy")
	else:
		queue_free()
	


func _on_collision_area_body_entered(body):
	if !resource.can_be_destroyed:
		return
	
	if !body is Player:
		return 
		
	resource.lives -= 1
	sprite_2d.frame = start_lives - resource.lives
	
	
	destroy()
