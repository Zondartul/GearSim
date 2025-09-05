extends Node
# Controller for Workspace
@export var MWorkspace:Node = null

#quick hax and debug stuff
@export var PanelGear:Node = null;
@export var tool:Node = null;

func _on_btn_axle_pressed() -> void:	MWorkspace.add_part_by_name("axle");
func _on_btn_gear_pressed() -> void:	tool.set_tool_by_name("place_gear");
func _on_btn_link_pressed() -> void:	MWorkspace.add_part_by_name("link"); 
func _on_btn_cam_pressed() -> void:		MWorkspace.add_part_by_name("cam"); 
func _on_btn_belt_pressed() -> void:	MWorkspace.add_part_by_name("belt"); 
func _on_btn_clutch_pressed() -> void:	MWorkspace.add_part_by_name("clutch"); 
func _on_btn_arm_pressed() -> void:		MWorkspace.add_part_by_name("arm"); 
func _on_btn_ground_pressed() -> void:	MWorkspace.add_part_by_name("ground"); 
func _on_btn_port_pressed() -> void:	MWorkspace.add_part_by_name("port"); 
func _on_btn_assy_pressed() -> void:	MWorkspace.add_part_by_name("assy"); 
func _on_btn_spring_pressed() -> void:	MWorkspace.add_part_by_name("spring"); 
func _on_btn_brake_pressed() -> void:	MWorkspace.add_part_by_name("brake"); 
func _on_btn_damper_pressed() -> void:	MWorkspace.add_part_by_name("damper"); 
func _on_btn_mass_pressed() -> void:	MWorkspace.add_part_by_name("mass"); 
func _on_btn_motor_pressed() -> void:	MWorkspace.add_part_by_name("motor"); 
func _on_btn_geneva_pressed() -> void:	MWorkspace.add_part_by_name("geneva"); 
func _on_btn_diff_pressed() -> void:	MWorkspace.add_part_by_name("diff"); 

func add_part(part:WorkspaceItem):
	MWorkspace.add_part(part);

var selected_part = null;

func select_part(part:WorkspaceItem):
	if part is PartGear:	PanelGear.model = part;
	else:					PanelGear.model = null;
	selected_part = part;
	
func unselect_part():
	select_part(null);
