extends Node

@export var VWorkspace:Control;
@export var n_spatial:Node;
const script_geometry = preload("res://logic/workspace/geometry.gd")

func _process(_delta):
	process_mouseover();

func process_mouseover():
	var mp = VWorkspace.get_local_mouse_position();
	var mouseover_part = n_spatial.get_mouseover_part(mp);
	if mouseover_part:
		VWorkspace.draw_my_circle(mouseover_part.position, script_geometry.get_line_size(mouseover_part));
		VWorkspace.closest_circle.default_color = Color.GREEN;
		VWorkspace.hide_my_line();
	else:
		var closest_part = n_spatial.get_nearby_part(mp, 200);
		if closest_part:
			VWorkspace.draw_my_circle(closest_part.position, script_geometry.get_line_size(closest_part));
			VWorkspace.closest_circle.default_color = Color.YELLOW;
			VWorkspace.draw_my_line(mp, closest_part.position);
		else:
			VWorkspace.draw_my_circle(mp, 10.0);
			VWorkspace.closest_circle.default_color = Color.GRAY;
			VWorkspace.hide_my_line();
