extends State
class_name enemy_die

func process_frame(_delta: float):
	parent.queue_free()
