extends State
class_name enemy_die

func enter():
	anim_player.play("die")
	anim_player.connect("animation_finished", _on_animation_finished)
	

func _on_animation_finished(animation_name):
	if animation_name == "die":
		parent.queue_free()
