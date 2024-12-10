extends Item
class_name No_momentum_use_item


func _on_area_2d_body_entered(player: Node2D):
	super(player)
	resource.player = player
