extends Entitiy_effect_resource
class_name Player_effect_resource

@export_group("no momentum use")
@export var no_momentum_use: No_momentum_use_item_resource
var no_momentum_use_reset_condition = func(): return GPS.last_state is Player_moving


var effects: Dictionary # = {
	#"no_momentum_use": [effect_resource.no_momentum_use, effect_resource.no_momentum_use_reset_condition, false]
#}
# --> init in player script "fill_effect_dict()"
#no ready functions in Resoruce scripts
#exports getting value to late to initalize here 
#trying to keep the commented dictionary up to date 
#so its not needed to switch between player script and this script
#would also be a constant if possible

func reset_effects():  ##effects which have a finite amount of uses --> item_resource.uses and item.resource.has_timeout can be resetted here
	for effect in effects:
		var current_effect = effects.get(effect)
		if !current_effect:
			continue
		if !current_effect[1].call(): ##condition
			continue
		if !current_effect[0].has_timeout:
			current_effect[2] = false
			
func no_momentum_use_active() -> bool:
	return effects["no_momentum_use"][2] == true
	
