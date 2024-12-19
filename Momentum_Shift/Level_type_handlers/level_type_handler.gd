extends Node
class_name Level_Type_Handler

var floor: Ground
var wall: Border

var grounds = {
	"default_floor": load("res://Environment/Ground/default_floor/default_floor.tscn")
}

var borders = {
	"default_wall": load("res://Environment/Border/Default_wall/Default_wall.tscn")
}

func handle():
	pass

func get_floor_to_place() -> TileMapLayer:
	return null
	
func get_wall_to_place() -> Border:
	return null
