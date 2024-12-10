extends Interactable_resource
class_name Item_resource

@export var has_timeout: bool
@export var timeout: float
@export var uses: int

func start_timer(owner):
	var timer: SceneTreeTimer =  owner.get_tree().create_timer(timeout)
	await timer.timeout
	remove_effect(owner)

func add_effect(owner):
	if has_timeout:
		start_timer(owner)
	else:
		uses -= 1

func remove_effect(owner):
	owner.texture = null
	owner.set_meta("Effect_resource", null)
