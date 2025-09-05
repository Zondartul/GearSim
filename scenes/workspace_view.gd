extends Panel

#var parts = [];
# let's draw a line to the closest object
#var closest_line:Line2D = Line2D.new();
#var closest_circle:Line2D = Line2D.new()

@export var n_sfx:Node;
@export var n_spatial:Node;
@export var n_mouseover:Node;
@export var n_mouse_drag:Node;
@export var n_mouse_grab:Node;
@export var n_mouse_select:Node;
@export var n_tool:Node;
const script_geometry = preload("res://logic/workspace/geometry.gd")

#func _ready():
	#script_geometry.gen_circle(closest_circle);
	#add_child(closest_line);
	#add_child(closest_circle);

func _on_model_sig_item_added(node:WorkspaceItem) -> void:
	add_child(node);
	#var v:Node2D = node.viewmodel;
	#v.position = get_rect().get_center(); 
	#add_child(v);
	#parts.append(v);
	n_sfx.play_sound_put_object();
	print("workspace_view added_item");

#func gen_closest_circle():
#	script_geometry.gen_circle(closest_circle);
	

func draw_shape(shape:Line2D, pos:Vector2, shape_size:float, color:Color):
	if shape_size == 0.0:
		shape.hide();
	else:
		shape.show();
		shape.position = pos;
		#shape.scale = Vector2(1,1)*shape_size;
		script_geometry.resize_line(shape, shape_size);
		shape.default_color = color;
		#closest_circle.width = 1.0;
		#shape.width = -1.0;
		shape.move_to_front();

func draw_line_shape(shape:Line2D, pos1:Vector2, pos2:Vector2):
	shape.clear_points();
	shape.add_point(pos1);
	shape.add_point(pos2);
	shape.width = 1.0;
	shape.show();

#func _process(_delta):
#	process_mouseover();
#	if is_dragging: process_drag();
#	if is_grabbing: process_grab();

func _gui_input(event):
	if n_tool.on_event(event): return;
	n_mouse_select.on_event(event);
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
