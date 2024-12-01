extends entity
class_name Player

@export var momentum_bar: ProgressBar
@export var future_momentum_bar: ProgressBar

var circle_color: Color = Color.RED
var momentum: float = 100
var future_momentum: float = 100

const MOUSE_DISTANCE_BUFFER: int = 100
const MAX_MOMENTUM: int = 100

signal got_hit(damage: int)

func _ready():
	super()
	connect("got_hit", on_hit)
	init_momentum_bars()
	
func _draw():
	var local_position = to_local(global_position)
	draw_circle(local_position, MOUSE_DISTANCE_BUFFER, circle_color, false, 1, true) ##changing color gets called in states --> calling _draw from there not working

func init_momentum_bars():
	momentum_bar.max_value = MAX_MOMENTUM
	momentum_bar.value = MAX_MOMENTUM
	future_momentum_bar.max_value = MAX_MOMENTUM
	future_momentum_bar.value = MAX_MOMENTUM
	future_momentum_bar.hide()

func on_hit(damage: int):
	%state_machine.current_state = %state_machine/hit
