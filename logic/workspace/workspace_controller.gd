extends Node
# Controller for Workspace
@export var model:Node = null

#quick hax and debug stuff
@export var PanelGear:Node = null;
@export var tool:Node = null;

func _on_btn_axle_pressed() -> void:	model.add_part("axle");
func _on_btn_gear_pressed() -> void:	tool.set_tool_by_name("place_gear");#var gear = model.add_part("gear"); PanelGear.model = gear;
func _on_btn_link_pressed() -> void:	model.add_part("link"); 
func _on_btn_cam_pressed() -> void:		model.add_part("cam"); 
func _on_btn_belt_pressed() -> void:	model.add_part("belt"); 
func _on_btn_clutch_pressed() -> void:	model.add_part("clutch"); 
func _on_btn_arm_pressed() -> void:		model.add_part("arm"); 
func _on_btn_ground_pressed() -> void:	model.add_part("ground"); 
func _on_btn_port_pressed() -> void:	model.add_part("port"); 
func _on_btn_assy_pressed() -> void:	model.add_part("assy"); 
func _on_btn_spring_pressed() -> void:	model.add_part("spring"); 
func _on_btn_brake_pressed() -> void:	model.add_part("brake"); 
func _on_btn_damper_pressed() -> void:	model.add_part("damper"); 
func _on_btn_mass_pressed() -> void:	model.add_part("mass"); 
func _on_btn_motor_pressed() -> void:	model.add_part("motor"); 
func _on_btn_geneva_pressed() -> void:	model.add_part("geneva"); 
func _on_btn_diff_pressed() -> void:	model.add_part("diff"); 
