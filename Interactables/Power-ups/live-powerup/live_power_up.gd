extends Power_up
class_name Live_power_up

func _on_area_2d_body_entered(player: Node2D):
	super(player)
	player.update_lives(resource.lives_to_add, player.add)

	
