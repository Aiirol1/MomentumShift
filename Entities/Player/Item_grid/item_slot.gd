extends TextureRect

var resource: Item_resource

func _process(delta):
	if resource:
		$Key.show()
		show_time_left_for_item(delta)

func show_uses_for_item():
	if !resource:
		return
	
	var uses_display: Label = get_child(0)
	if !resource.has_timeout:
		uses_display.text = str(resource.uses)
	else:
		uses_display.text = str(resource.timeout) + "s"
		

func show_time_left_for_item(delta: float):
	if resource.is_running:
		var time_display: Label = get_child(0)
		resource.timeout -= delta
		var time_left: float = snappedf(resource.timeout, 0.1) ##round time_left
		time_display.text = str(time_left) + "s"

func add_item(resource: Item_resource):
	set_meta("Effect_resource", resource)
	self.resource = get_meta("Effect_resource")
	show_uses_for_item()
	
func remove_item():
	texture = null
	resource = null
	$Key.hide()
	remove_meta("Effect_resource")

	var display: Label = get_child(0)
	display.set_deferred("text", "")
