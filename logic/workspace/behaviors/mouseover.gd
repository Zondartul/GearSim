extends Node

@export var VWorkspace:Control;
@export var n_spatial:Node;
const script_geometry = preload("res://logic/workspace/geometry.gd")

var closest_circle = Line2D.new();
var closest_line = Line2D.new();

func _ready():
	script_geometry.gen_circle(closest_circle);
	VWorkspace.add_child(closest_circle);
	closest_circle.hide();
	VWorkspace.add_child(closest_line);
	closest_line.hide();

func _process(_delta):
	process_mouseover();

func process_mouseover():
	var mp = VWorkspace.get_local_mouse_position();
	var mouseover_part = n_spatial.get_mouseover_part(mp);
	if mouseover_part:
		VWorkspace.draw_shape(closest_circle, mouseover_part.position, mouseover_part.radius, Color.GREEN);
		#VWorkspace.closest_circle.default_color = Color.GREEN;
		closest_line.hide()
	else:
		var closest_part = n_spatial.get_nearby_part(mp, 200);
		if closest_part:
			VWorkspace.draw_shape(closest_circle, closest_part.position, closest_part.radius, Color.YELLOW);
			#VWorkspace.closest_circle.default_color = Color.YELLOW;
			VWorkspace.draw_line_shape(closest_line, mp, closest_part.position);
		else:
			VWorkspace.draw_shape(closest_circle, mp, 10.0, Color.GRAY);
			#VWorkspace.closest_circle.default_color = Color.GRAY;
			closest_line.hide()
