extends StaticBody2D
class_name Obstacle

var collision: KinematicCollision2D

@export var resource: Obstacle_resource

func _ready():
	resource = resource.duplicate()


func _process(_delta):
	pass
		
func destroy():
	if resource.lives <= 0:
		queue_free()
	


func _on_collision_area_body_entered(body):
	if !resource.can_be_destroyed:
		return
	
	if !body is Player:
		return 
		
	resource.lives -= 1
	
	destroy()
