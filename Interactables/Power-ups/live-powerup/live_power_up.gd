extends Power_up
class_name Live_power_up

func _on_area_2d_body_entered(player: Node2D):
	super(player)
	player.update_lives(resource.lives_to_add, player.add)
	print(player.lives)

func _on_animation_player_animation_finished(anim_name: StringName):
	if anim_name == "collect":
		queue_free()
	
