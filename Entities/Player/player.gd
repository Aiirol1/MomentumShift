extends entity
class_name Player

@onready var momentum_bar: TextureProgressBar = %Momentum_bar
@onready var future_momentum_bar: TextureProgressBar = %Future_momentum_bar
@onready var camera = %Camera2D
@onready var health_bar = %Health_bar
@onready var item_grid = %Item_grid

var circle_color: Color = Color.RED
var momentum: float = 100
var future_momentum: float = 100
var mouse_position: Vector2
var charged_mouse_pos: Vector2


const ITEM_SLOT_NAME_PREFIX: String = "Item_"


var add = func(value, value_to_add):
	var new_value = value + value_to_add
	if new_value > MAX_HEALTH:
		return MAX_HEALTH
	else:
		return value + value_to_add

var substract = func(value, value_to_substract):
	var new_value = value - value_to_substract
	if new_value <= 0:
		return 0
	else:
		return value - value_to_substract

const MOUSE_DISTANCE_BUFFER: int = 100
const MAX_MOMENTUM: int = 100
const CAMERA_ZOOM: Vector2 = Vector2(1, 1)
const MAX_HEALTH: int = 1000

signal got_hit(damage: int)

func _ready():
	super()
	connect("got_hit", on_hit)
	init_momentum_bars()
	init_health_bar()
	init_item_slots()
	fill_effect_dict()
	
func _physics_process(delta):
	state_machine.process_physics(delta)
	
	if Input.is_action_just_pressed("F"):
		refresh_momentum()
	
func _draw():
	var local_position = to_local(global_position)
	draw_circle(local_position, MOUSE_DISTANCE_BUFFER, circle_color, false, 1, true) ##changing color gets called in states --> calling _draw from there not working

func init_momentum_bars():
	momentum_bar.max_value = MAX_MOMENTUM
	momentum_bar.value = MAX_MOMENTUM
	future_momentum_bar.max_value = MAX_MOMENTUM
	future_momentum_bar.value = MAX_MOMENTUM
	future_momentum_bar.hide()
	
func init_health_bar():
	health_bar.max_value = lives
	health_bar.value = lives
	

func on_hit(_damage: int):
	animation_player.play("flash")
	state_machine.current_state = %state_machine/hit

func set_mouse_position():
	mouse_position = get_global_mouse_position()
	
func get_mouse_position() -> Vector2:
	return get_global_mouse_position()
	
func mouse_in_near(mouse_distance_buffer: int) -> bool:
	var distance = abs(mouse_position - global_position)
	return distance.length() <= mouse_distance_buffer
	
func reset_zoom():
	var tween = get_tree().create_tween()
	tween.tween_property(camera, "zoom", CAMERA_ZOOM, 0.2)

func hide_circle():
	circle_color = Color.TRANSPARENT
	queue_redraw()

func reset_future_momentum():
	var tween = get_tree().create_tween()
	tween.tween_property(future_momentum_bar, "value", momentum, 0.6)
	tween.finished.connect(tween_finished)
	
func tween_finished():
	future_momentum_bar.hide()

func update_momentum(value, operation: Callable, source: String = ""):
	var no_momentum_use = func(): return effect_resource.no_momentum_use_active() and source == "Input"
	
	if no_momentum_use.call():
		return
	
	momentum = operation.call(momentum, value)
	var tween = get_tree().create_tween()
	tween.tween_property(momentum_bar, "value", momentum, 0.6)
	
func refresh_momentum():
	var momentum_to_fill = MAX_MOMENTUM - momentum
	
	if lives > momentum_to_fill: 
		momentum = MAX_MOMENTUM
		update_lives(momentum_to_fill, substract)
	else:
		momentum += lives
		update_lives(lives, substract)
	
	var tween = get_tree().create_tween()
	tween.tween_property(momentum_bar, "value", momentum, 1)
	
func update_lives(value, operation: Callable):
	lives = operation.call(lives, value)
	
	var tween = get_tree().create_tween()
	tween.tween_property(health_bar, "value", lives, 1)
	

func get_next_free_item_slot() -> TextureRect:
	for child in item_grid.get_children():
		if !child is TextureRect:
			continue
		elif child.texture:
			continue
		else: 
			return child
	return null

func init_item_slots():
	var count = 1
	for child in item_grid.get_children():
		if child is TextureRect:
			child.name = ITEM_SLOT_NAME_PREFIX + str(count)
			count += 1

func _unhandled_key_input(event):
	if velocity == Vector2.ZERO: #no movement
		if event.is_pressed() and event is InputEventKey:
			use_item(event)
			
		
func use_item(event: InputEventKey):
	var item_slots = item_grid.get_children()
	var item_slot_to_use = ITEM_SLOT_NAME_PREFIX + event.as_text_keycode()
	
	for item_slot in item_slots:
		if item_slot.name == item_slot_to_use and item_slot.has_meta("Effect_resource"):
			var effect_resource = item_slot.get_meta("Effect_resource")
			effect_resource.call("add_effect", item_slot)
			item_slot.show_uses_for_item()
			
func fill_effect_dict():
	effect_resource.effects = {
	"no_momentum_use": [effect_resource.no_momentum_use, effect_resource.no_momentum_use_reset_condition, false]
}
	
func reset_effects():
	effect_resource.reset_effects()

func set_no_momentum_use(value: bool):
	effect_resource.effects["no_momentum_use"][2] = value
