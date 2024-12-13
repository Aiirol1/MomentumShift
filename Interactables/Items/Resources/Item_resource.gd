extends Interactable_resource
class_name Item_resource

@export var has_timeout: bool
@export var timeout: float
@export var uses: int

var time_left: float
var is_running: bool = false


func start_timer(owner):
	var timer: SceneTreeTimer =  owner.get_tree().create_timer(timeout)
	is_running = true
	await timer.timeout
	remove_effect(owner)

func add_effect(owner):
	if !is_resource_active():
		if has_timeout:
			start_timer(owner)
		else:
			uses -= 1
			if uses <= 0:
				remove_effect(owner)
				return

func remove_effect(owner: TextureRect):
	is_running = false
	owner.remove_item()

func is_resource_active() -> bool:
	return false
	
