extends WorkspaceTool
class_name ToolPlaceGear

const class_Gear = preload("res://logic/classes/Primitive/Gear.gd");
var preview_part = PartGear.new();

func _ready():
	preview_part.update();
	VWorkspace.add_child(preview_part.viewmodel);
	print("ToolPlaceGear ready");
	
func _process(_delta):
	preview_part.viewmodel.position = VWorkspace.get_local_mouse_position();
	
