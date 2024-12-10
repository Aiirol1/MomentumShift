extends Item_resource
class_name No_momentum_use_item_resource

var player: Player

func add_effect(owner):
	super(owner)
	player.effect_resource.no_momentum_use = true
	
			
	if uses <= 0:
		remove_effect(owner)
	

		
func remove_effect(owner):
	super(owner)
	player.effect_resource.no_momentum_use = false
