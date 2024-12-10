extends Interactable
class_name Item

@onready var active_items = %Active_Items
@onready var area_2d = %Area2D

func _ready():
	pass
		
func add_to_item_slot(player: Player):
	var item_slot: TextureRect = player.get_next_free_item_slot()
	
	if item_slot:
		item_slot.texture = $Sprite2D.texture
		item_slot.set_meta("Effect_resource", resource)
		change_parent_to_active_items()
		collect()

func change_parent_to_active_items():
	get_parent().call_deferred("remove_child", self)
	active_items.call_deferred("add_child", self)

func _on_area_2d_body_entered(body: Node2D):
	add_to_item_slot(body)
	
func collect():
	position = Vector2(0, 0)
	area_2d.set_deferred("monitoring", false)
	hide()
