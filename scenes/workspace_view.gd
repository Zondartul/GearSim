extends Panel

var parts = [];
# let's draw a line to the closest object
var closest_line:Line2D = Line2D.new();
var closest_circle:Line2D = Line2D.new()

@export var n_sfx:Node;
@export var n_spatial:Node;
@export var n_mouseover:Node;
@export var n_mouse_drag:Node;
@export var n_mouse_grab:Node;
const script_geometry = preload("res://logic/workspace/geometry.gd")

func _ready():
	script_geometry.gen_circle(closest_circle);
	add_child(closest_line);
	add_child(closest_circle);

func _on_model_sig_item_added(node) -> void:
	var v:Node2D = node.viewmodel;
	v.position = get_rect().get_center(); 
	add_child(v);
	parts.append(v);
	n_sfx.play_sound_put_object();
	print("workspace_view added_item");

func gen_closest_circle():
	script_geometry.gen_circle(closest_circle);
	

func draw_my_circle(pos:Vector2, radius:float):
	if radius == 0.0:
		closest_circle.hide();
	else:
		closest_circle.show();
		closest_circle.position = pos;
		#closest_circle.scale = Vector2(1,1)*radius;
		script_geometry.resize_line(closest_circle, radius);
		closest_circle.width = 1.0;
		closest_circle.move_to_front();

func draw_my_line(pos1:Vector2, pos2:Vector2):
	closest_line.clear_points();
	closest_line.add_point(pos1);
	closest_line.add_point(pos2);
	closest_line.width = 1.0;
	closest_line.show();

func hide_my_line(): closest_line.hide();


#func _process(_delta):
#	process_mouseover();
#	if is_dragging: process_drag();
#	if is_grabbing: process_grab();

func _gui_input(event):
	if G.is_LMB_down(event):
		var mp = get_local_mouse_position();
		var part = n_spatial.get_mouseover_part(mp);
		if part:
			n_mouse_drag.press_part(mp, part);
	if G.is_LMB_up(event):
		n_mouse_drag.release_part();
	if G.is_RMB_down(event):
		var mp = get_local_mouse_position();
		var part = n_spatial.get_mouseover_part(mp);
		if part:
			n_mouse_grab.grab_part(mp, part);
	if G.is_RMB_up(event):
		n_mouse_grab.ungrab_part();
