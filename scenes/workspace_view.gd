extends Panel

var parts = [];
# let's draw a line to the closest object
var closest_line:Line2D = Line2D.new();
var closest_circle:Line2D = Line2D.new()

func _ready():
	gen_circle();
	add_child(closest_line);
	add_child(closest_circle);

func _on_model_sig_item_added(node) -> void:
	var v:Node2D = node.viewmodel;
	v.position = get_rect().get_center(); 
	add_child(v);
	parts.append(v);
	print("workspace_view added_item");


# also look at using built-in draw_circle()
func gen_circle():
	closest_circle.clear_points();
	var n_sides = 32;
	var r = 1.0;
	for i in range(n_sides+1):
		var th = 2*PI*i/float(n_sides);
		var x = r*cos(th);
		var y = r*sin(th);
		closest_circle.add_point(Vector2(x,y));

func get_line_size(line:Line2D):
	var max_r = 0.0;
	for p in line.points:
		max_r = max(max_r, p.length());
	return max_r;

func resize_line(line:Line2D, new_size:float):
	var max_r = get_line_size(line);
	for i in range(line.get_point_count()):
		var p = line.points[i];
		line.set_point_position(i,p*new_size/max_r);

func draw_my_circle(pos:Vector2, radius:float):
	closest_circle.position = pos;
	#closest_circle.scale = Vector2(1,1)*radius;
	resize_line(closest_circle, radius);
	closest_circle.width = 1.0;
	closest_circle.move_to_front();

func draw_my_line(pos1:Vector2, pos2:Vector2):
	closest_line.clear_points();
	closest_line.add_point(pos1);
	closest_line.add_point(pos2);
	closest_line.width = 1.0;
	closest_line.show();

func hide_my_line(): closest_line.hide();

func part_dist_comparison(A, B, pos):
	return (A.position - pos).length() < (B.position - pos).length();

func get_parts_by_distance(pos:Vector2)->Array:
	var res_parts = parts.duplicate();
	res_parts.sort_custom(part_dist_comparison.bind(pos));
	return res_parts;

func get_part_mouse_dist(part)->float:
	return (part.position - get_local_mouse_position()).length();

#func get_closest_part(pos:Vector2)->Node:
	#var min_d = 999.0;
	#var min_part = null;
	#for part in parts:
		#var d = (part.position - pos).length();
		#if d < min_d:
			#min_d = d;
			#min_part = part;
	#return min_part;

func get_mouseover_part(pos:Vector2):
	# mouseover part is the one that is close
	# and close enough to touch
	# and the smallest of those
	var sorted_parts = get_parts_by_distance(pos);
	var min_size = 999;
	var min_part = null;
	for part in sorted_parts:
		var dist = get_part_mouse_dist(part);
		var psize = get_line_size(part);
		if dist < psize:
			if psize < min_size:
				min_size = psize;
				min_part = part;
		#else keep going
	return min_part;

func get_nearby_part(pos:Vector2, max_dist:float):
	var sorted_parts = get_parts_by_distance(pos);
	if sorted_parts.size() > 0: 
		var part = sorted_parts[0];
		if get_part_mouse_dist(part) < max_dist:
			return sorted_parts[0];
	return null;

func _process(_delta):
	process_mouseover();
	if is_dragging: process_drag();

func process_mouseover():
	var mp = get_local_mouse_position();
	var mouseover_part = get_mouseover_part(mp);
	if mouseover_part:
		draw_my_circle(mouseover_part.position, get_line_size(mouseover_part));
		closest_circle.default_color = Color.GREEN;
		hide_my_line();
	else:
		var closest_part = get_nearby_part(mp, 200);
		if closest_part:
			draw_my_circle(closest_part.position, get_line_size(closest_part));
			closest_circle.default_color = Color.YELLOW;
			draw_my_line(mp, closest_part.position);
		else:
			draw_my_circle(mp, 10.0);
			closest_circle.default_color = Color.GRAY;
			hide_my_line();

func process_drag():
	drag_part.position = get_local_mouse_position() + drag_offs;

func is_LMB_down(event): return (event is InputEventMouseButton) and (event.button_index == MOUSE_BUTTON_LEFT) and (event.pressed);
func is_LMB_up(event):  return (event is InputEventMouseButton) and (event.button_index == MOUSE_BUTTON_LEFT) and (not event.pressed);

var is_dragging = false;
var drag_offs:Vector2 = Vector2(0,0);
var drag_part = null;

func _gui_input(event):
	if is_LMB_down(event):
		var mp = get_local_mouse_position();
		var part = get_mouseover_part(mp);
		if part:
			press_part(mp, part);
	if is_LMB_up(event):
		release_part();

func press_part(mp:Vector2, part:Node):
	drag_part = part;
	drag_offs = part.position - mp;
	is_dragging = true;

func release_part():
	is_dragging = false;
	drag_part = null;
