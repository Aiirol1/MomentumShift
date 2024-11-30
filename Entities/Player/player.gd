extends entity

@export var momentum_bar: ProgressBar
@export var future_momentum_bar: ProgressBar

var circle_color: Color = Color.RED
var momentum: float = 100
var future_momentum: float = 100

const MOUSE_DISTANCE_BUFFER: int = 100
const MAX_MOMENTUM: int = 100

func _ready():
	super()
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
