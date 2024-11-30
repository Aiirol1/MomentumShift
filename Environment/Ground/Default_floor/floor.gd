extends Ground

var _min_bounds
var _max_bounds
var bounds


func _ready():
	spawn_floor()
	
func spawn_floor():
	var random_number: RandomNumberGenerator = RandomNumberGenerator.new()
	bounds = get_random_bounds(30, 30, 10)
	_max_bounds = max(bounds.x, bounds.y)
	_min_bounds = min(bounds.x, bounds.y)
	
	for width in bounds.x:
		for height in bounds.y:
			var random_atlas_value_x = random_number.randi_range(0, 1)
			var random_atlas_value_y = random_number.randi_range(0, 1)
			var atlas_coords: Vector2 = Vector2(random_atlas_value_x, random_atlas_value_y)
			var coords: Vector2 = Vector2(width, height)
			
			if is_at_line(0, coords): ##first line
				if can_draw(2): ##--> 33% to draw cell (1 is 50%)
					set_cell(coords, 1, atlas_coords)
					
			elif is_at_line(1, coords):  ##second line
				draw_width_second_line(coords, atlas_coords)
				draw_height_second_line(coords, atlas_coords)
				
			elif is_at_line(_max_bounds-2, coords): ## second outer line 
				if can_draw(1):
					set_cell(coords, 1, atlas_coords)
					
			elif is_at_line(_min_bounds-1, coords):
				last_line_on_min_value(coords, atlas_coords)
					
			elif is_at_line(_max_bounds-1, coords):
				last_line(coords, atlas_coords)
					
			else: set_cell(coords, 1, atlas_coords) ##is on other line just draw the cell


func draw_width_second_line(coords: Vector2i, atlas_coords: Vector2i):
	if coords.x == 1:
		if has_tile_on_left_side(coords):
			set_cell(coords, 1, atlas_coords)
		elif can_draw(1):
			set_cell(coords, 1, atlas_coords)
			
func draw_height_second_line(coords: Vector2i, atlas_coords: Vector2i):
	if coords.y == 1:
		if has_tile_on_top(coords):
			set_cell(coords, 1, atlas_coords)
		elif can_draw(1):
			set_cell(coords, 1, atlas_coords)
			
func draw_width_second_outer_line(coords: Vector2i, atlas_coords: Vector2i):
	if coords.x == _min_bounds - 1:
		if has_tile_on_left_side(coords) and can_draw(1): 
			set_cell(Vector2i(_min_bounds, coords.y), 1, atlas_coords)
	elif bounds.x == _max_bounds:
		set_cell(coords, 1, atlas_coords)
		
func draw_height_second_outer_line(coords: Vector2i, atlas_coords: Vector2i):
	if coords.y == _min_bounds - 1:
			if has_tile_on_top(coords) and can_draw(2):
				set_cell(Vector2i(coords.x, _min_bounds), 1, atlas_coords)

		
func draw_width_outer_line(coords: Vector2i, atlas_coords: Vector2i):
	if coords.x == _max_bounds - 1:
		if has_tile_on_left_side(coords) and can_draw(1): 
			set_cell(coords, 1, atlas_coords)
			
func draw_height_outer_line(coords: Vector2i, atlas_coords: Vector2i):
	if coords.y == _max_bounds -1:
		if has_tile_on_top(coords) and can_draw(2):
			set_cell(coords, 1, atlas_coords)
			
func last_line_on_min_value(coords: Vector2i, atlas_coords: Vector2i):
	if is_min_bounds(bounds.x):
		draw_width_second_outer_line(coords, atlas_coords)
	elif is_max_bounds(bounds.x):
		set_cell(coords, 1, atlas_coords)
		
	if is_min_bounds(bounds.y):
		draw_height_second_outer_line(coords, atlas_coords)
	elif is_max_bounds(bounds.y):
		set_cell(coords, 1, atlas_coords)
		
func last_line(coords: Vector2i, atlas_coords: Vector2i):
	if is_max_bounds(coords.x):
		draw_width_outer_line(coords, atlas_coords)
	if is_max_bounds(coords.x):
		draw_height_outer_line(coords, atlas_coords)
		
func get_left_tiles_x_values() -> Array[Vector2i]:
	return get_smalles_x_values(bounds.y)
	
func get_top_tiles_y_values() -> Array[Vector2i]:
	return get_smallest_y_values(bounds.x)
	
func get_right_tiles_x_values() -> Array[Vector2i]:
	return get_heighest_x_values(bounds.y)
	
func get_ground_tiles_y_values() -> Array[Vector2i]:
	return get_heighest_y_values(bounds.x)

func is_min_bounds(value: int) -> bool:
	return value == _min_bounds
	
func is_max_bounds(value: int) -> bool:
	return value == _max_bounds
	
