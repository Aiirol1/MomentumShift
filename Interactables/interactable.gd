extends StaticBody2D
class_name Interactable

@export var resource: Resource

@onready var animation_player: AnimationPlayer = %AnimationPlayer

func _ready() -> void:
	resource = resource.duplicate(true) ##else its not unique and shares all values with other resources of same type
	animation_player.play("Idle")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		animation_player.play("collect")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "collect":
		queue_free()
