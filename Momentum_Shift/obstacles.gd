extends Node2D

var obstacle_count: int = 50 ##has to be depandable on difficulty (later) 
var blocked_tiles: Array[Vector2]
var tile_size
var half_tile_size
var calc_pos = func(pos): return pos * tile_size + half_tile_size

const OBSTACLES_DICT: Dictionary = {
	"box": preload("res://Obstacles/Box/Box.tscn")
}


func spawn_obstacles(floor: TileMapLayer):
	tile_size = floor.tile_set.tile_size as Vector2
	half_tile_size = floor.tile_set.tile_size / 2 as Vector2
	add_spawn_proof_to_blocked_tiles()
	
	for i in obstacle_count:
		var random_pos = calculate_pos(floor)
			
		add_obstacle(random_pos)
		blocked_tiles.append(random_pos)
	
func tile_is_occupied(pos: Vector2) -> bool:
	return blocked_tiles.has(pos)
		
func add_obstacle(pos: Vector2):
	var new_obstacle: Obstacle = OBSTACLES_DICT["box"].instantiate()
	new_obstacle.position = pos
	add_child(new_obstacle)
	
func calculate_pos(floor: TileMapLayer) -> Vector2:
	var floor_cells = floor.get_used_cells()
	var random: RandomNumberGenerator = RandomNumberGenerator.new()
	var random_cell = func(): return floor_cells[random.randi_range(0, floor_cells.size() - 1)] as Vector2
	var random_pos = random_cell.call()
	random_pos = calc_pos.call(random_pos)

	var loops: int = 0
	while tile_is_occupied(random_pos) and loops < floor_cells.size():
		random_pos = random_cell.call()
		random_pos = calc_pos.call(random_pos)
		loops += 1
		
	return random_pos
	
func add_spawn_proof_to_blocked_tiles():
	for value in GPS.spawn_proof_area:
		value = value as Vector2
		blocked_tiles.append(calc_pos.call(value))