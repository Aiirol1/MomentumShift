extends TileMapLayer
class_name Ground

enum directions {
	STRAIGHT,
	DOWN
}

var random_number_gen: RandomNumberGenerator
var total_width: int
var total_height: int
var next_direction: directions
var direction: directions
var last_step: bool = false

var inner_tiles_straight: Array[Vector2]
var outer_tiles_straight: Array[Vector2]
var inner_tiles_down: Array[Vector2]
var outer_tiles_down: Array[Vector2]

const MIN_STEPS: int = 10
const MAX_STEPS: int = 20

func get_random_steps() -> int:
	return random_number_gen.randi_range(MIN_STEPS, MAX_STEPS)

func get_random_height(min: int, max: int) -> int:
	return random_number_gen.randi_range(min, max)
	
func get_random_width(min: int, max: int) -> int:
	return random_number_gen.randi_range(min, max)
	
func get_random_direction() -> directions:
	var rand = random_number_gen.randi_range(0, 1)
	var new_direction = directions.STRAIGHT if rand == 0 else directions.DOWN
	return new_direction
	
func get_random_atlas_value() -> Vector2:
	var random_atlas_value_x = random_number_gen.randi_range(0, 1)
	var random_atlas_value_y = random_number_gen.randi_range(0, 1)
	return Vector2(random_atlas_value_x, random_atlas_value_y)

func _ready(): 
	random_number_gen = RandomNumberGenerator.new()
	
func set_player_starting_pos():
	pass
	
func draw_ground():
	pass
			
func draw_straight(first_step: bool):
	var height = get_random_height(5, 7)
	var width = get_random_width(10, 12)
	total_width += width
	
	for i in range(height):
		for j in range(width):
			var cell_coords: Vector2 = Vector2(j+total_width-width, i+total_height-height)
			set_cell(cell_coords, 1, get_random_atlas_value())
			if i == 0:
				outer_tiles_straight.append(cell_coords)
			elif i == height-1:
				inner_tiles_straight.append(cell_coords)
			
			if next_dir_is_value(directions.DOWN) and is_straight_at_end(j, width) and !last_step:
				outer_tiles_down.append(cell_coords)
			
			if first_step: add_tile_to_spawn_proof(cell_coords)
			
			var is_at_beginning = func(): return total_width - width == 0 and j == 0
			if  is_at_beginning.call():
				inner_tiles_down.append(cell_coords)
	
func draw_down(first_step: bool):
	var width = get_random_width(5, 7)
	var height = get_random_height(10, 12)
	total_height += height
	
	for i in range(width):
		for j in range(height):
			var cell_coords: Vector2 = Vector2(i+total_width-width, j+total_height-height)
			set_cell(cell_coords, 1, get_random_atlas_value())
			if i == 0:
				inner_tiles_down.append(cell_coords)
			elif i == width-1:
				outer_tiles_down.append(cell_coords)
				
			if next_dir_is_value(directions.STRAIGHT) and is_down_at_end(j, height) and !last_step:
				outer_tiles_straight.append(Vector2(cell_coords.x, cell_coords.y + 2)) #manipulate y coordinate because walls would not be placed correctly
			
			if first_step: add_tile_to_spawn_proof(cell_coords)
			
			var is_at_beginning = func(): return  total_height - height == 0 and j == 0
			if is_at_beginning.call():
				GPS.spawn_proof_area.append(cell_coords)
				outer_tiles_straight.append(cell_coords)

func is_straight_at_end(pos: int, width: int) -> bool:
	return pos == width - 1
	
func is_down_at_end(pos: int, height: int) -> bool:
	return pos == height - 1
	
func next_dir_is_value(value: directions):
	return next_direction == value

func add_tile_to_spawn_proof(tile: Vector2):
	GPS.spawn_proof_area.append(tile)
