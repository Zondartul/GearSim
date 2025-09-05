extends Node

@export var n_spatial:Node;
@export var CWorkspace:Node;

var selected_circle;

const script_geometry = preload("res://logic/workspace/geometry.gd")

func on_event(event)->bool:
	if click_detector(event, 200):
		var part = n_spatial.get_mouseover_part(event.position);
		if part:
			CWorkspace.select_part(part);
			clear_circle();
			gen_circle(part.radius);
			part.add_child(selected_circle);
			print("selected "+str(part.name))
		else:
			CWorkspace.unselect_part();
			clear_circle();
			print("unselected")
		return true;
	return false;

var press_time = 0;
func click_detector(event, timeout_ms)->bool:
	var t = Time.get_ticks_msec();
	if G.is_LMB_down(event): press_time = t;
	if G.is_LMB_up(event):
		var d = t - press_time;
		if d < timeout_ms:
			return true;
	return false;

func gen_circle(radius:float):
	selected_circle = Line2D.new();
	script_geometry.gen_circle(selected_circle)
	script_geometry.resize_line(selected_circle, radius);
	selected_circle.default_color = Color.GREEN;

func clear_circle():
	if selected_circle:
		selected_circle.queue_free(); 
		selected_circle = null;
