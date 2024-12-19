extends Level_Type_Handler
class_name Achieve_Goal



func handle():
	floor.draw_ground()
	wall.draw_wall()

func get_floor_to_place() -> Ground:
	floor = grounds["default_floor"].instantiate()
	print(floor)
	return floor

func get_wall_to_place() -> Border:
	wall = borders["default_wall"].instantiate()
	return wall
