extends Interactable
class_name Power_up


@onready var animation_player: AnimationPlayer = %AnimationPlayer

func _ready() -> void:
	animation_player.play("Idle")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		animation_player.play("collect")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	pass
