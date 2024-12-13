extends Item_resource
class_name No_momentum_use_item_resource

var player: Player


func add_effect(owner):
	super(owner)
	player.set_no_momentum_use(true)
	
		
func remove_effect(owner):
	super(owner)
	player.set_no_momentum_use(false)

func is_resource_active() -> bool:
	return player.effect_resource.no_momentum_use_active()
