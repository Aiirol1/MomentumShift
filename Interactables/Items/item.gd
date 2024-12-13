extends Interactable
class_name Item

@onready var area_2d = %Area2D


func add_to_item_slot(player: Player):
	var item_slot: TextureRect = player.get_next_free_item_slot()
	
	if item_slot:
		resource.time_left = resource.timeout
		item_slot.show_uses_for_item()
		item_slot.add_item(resource)
		item_slot.texture = $Sprite2D.texture
		item_slot.set_meta("Effect_resource", resource)


func _on_area_2d_body_entered(body: Node2D):
	super(body)
	add_to_item_slot(body)
