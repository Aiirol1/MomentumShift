extends CanvasLayer

@onready var health_bar = %Health_bar
@onready var health_display = %Health_display

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func init(resource: Enemy_resource):
	hide()
	health_bar.max_value = resource.lives
	health_bar.value = health_bar.max_value
	health_display.text = str(resource.lives)
	
func update(resource: Enemy_resource):
	health_display.text = str(resource.lives)
	var tween = get_tree().create_tween()
	tween.tween_property(health_bar, "value", resource.lives, 0.3)
