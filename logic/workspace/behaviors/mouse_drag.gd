extends Node

@export var VWorkspace:Control;

func _process(_delta):
	if is_dragging: process_drag();

func process_drag():
	drag_part.position = VWorkspace.get_local_mouse_position() + drag_offs;

var is_dragging = false;
var drag_offs:Vector2 = Vector2(0,0);
var drag_part = null;

func press_part(mp:Vector2, part:Node):
	drag_part = part;
	drag_offs = part.position - mp;
	is_dragging = true;

func release_part():
	is_dragging = false;
	drag_part = null;
