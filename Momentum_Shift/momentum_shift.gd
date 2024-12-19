extends Node2D

var floor: Ground
var wall: Border
	
enum LEVEL_TYPES {
	ACHIEVE_GOAL,
	ACHIEVE_GOAL_WITH_ITEM,
	ACHIEVE_SCORE,
	SURVIVE,
	BOSSFIGHT,
}

var level_type_handlers = {
	LEVEL_TYPES.ACHIEVE_GOAL: load("res://Momentum_Shift/Level_type_handlers/Achieve_goal/achieve_goal.tscn"),
	LEVEL_TYPES.ACHIEVE_GOAL_WITH_ITEM: load("res://Momentum_Shift/Level_type_handlers/Achieve_Goal_With_Item/achieve_goal_with_item.tscn"),
	LEVEL_TYPES.ACHIEVE_SCORE: load("res://Momentum_Shift/Level_type_handlers/Achieve_Score/achieve_score.tscn"),
	LEVEL_TYPES.SURVIVE: load("res://Momentum_Shift/Level_type_handlers/Survive/survive.tscn"),
	LEVEL_TYPES.BOSSFIGHT: load("res://Momentum_Shift/Level_type_handlers/Bossfight/bossfight.tscn"),
}

@onready var tile_maps = %Tile_maps
@onready var obstacles = %Obstacles
@onready var player = %Player


func _ready():
	handle_level_type(LEVEL_TYPES.ACHIEVE_GOAL)
	obstacles.spawn_obstacles(floor)
	player.position = GPS.starting_pos

	
func handle_level_type(level_type: LEVEL_TYPES):
	if level_type_handlers.has(LEVEL_TYPES.ACHIEVE_GOAL):
		var new_level_type: Level_Type_Handler = level_type_handlers[level_type].instantiate()
		add_child(new_level_type)
		set_tile_maps(new_level_type)
		new_level_type.handle()
	else:
		push_error("This level type does not exsit!")
	
func get_random_level_type() -> LEVEL_TYPES:
	var random: RandomNumberGenerator = RandomNumberGenerator.new()
	var random_level_type = random.randi_range(0, LEVEL_TYPES.size())
	return LEVEL_TYPES.get(random_level_type)


func set_tile_maps(level_type: Level_Type_Handler):
	floor = level_type.get_floor_to_place()
	tile_maps.add_child(floor)
	wall = level_type.get_wall_to_place()
	wall.floor = floor
	tile_maps.add_child(wall)
