extends WorkspaceTool
class_name ToolPlaceGear

const class_Gear = preload("res://logic/classes/Primitive/Gear.gd");
var preview_part = PartGear.new();

func _ready():
	#preview_part.update();
	VWorkspace.add_child(preview_part);
	CWorkspace.select_part(preview_part);
	print("ToolPlaceGear ready");
	
func _process(_delta):
	preview_part.position = VWorkspace.get_local_mouse_position();
	
func on_event(event)->bool:
	if G.is_LMB_down(event):
		CWorkspace.add_part(preview_part.clone());
		print("tpg click");
		return true;
	return super.on_event(event);

func _exit_tree():
	CWorkspace.select_part(null);
	preview_part.shutdown();
	preview_part.queue_free();
	print("tpg shutdown")
