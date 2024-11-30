extends CharacterBody2D


@onready var state_machine = %state_machine
@onready var function_component = %function_component


@export var momentum_bar: ProgressBar
@export var future_momentum_bar: ProgressBar

var circle_color: Color = Color.RED
var momentum: float = 100
var future_momentum: float = 100

const MOUSE_DISTANCE_BUFFER: int = 100
const MAX_MOMENTUM: int = 100
const MAX_CHARGING_VALUE: int = 4



func _ready():
	init_momentum_bars()
	state_machine.init(self, function_component)
	
func _unhandled_input(event):
	state_machine.process_input(event)
	
func _physics_process(delta):
	state_machine.process_physics(delta)
	
func _process(delta):
	state_machine.process_frame(delta)
	
func _draw():
	var local_position = to_local(global_position)
	draw_circle(local_position, MOUSE_DISTANCE_BUFFER, circle_color, false, 1, true) ##changing color gets called in states --> calling _draw from there not working

func init_momentum_bars():
	momentum_bar.max_value = MAX_MOMENTUM
	momentum_bar.value = MAX_MOMENTUM
	future_momentum_bar.max_value = MAX_MOMENTUM
	future_momentum_bar.value = MAX_MOMENTUM
	future_momentum_bar.hide()
