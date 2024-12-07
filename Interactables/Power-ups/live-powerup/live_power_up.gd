extends Power_up
class_name Live_power_up
#
func _on_area_2d_body_entered(body: Node2D):
	super(body)
	body.update_lives(resource.lives_to_add, body.add)
	print(body.lives)
