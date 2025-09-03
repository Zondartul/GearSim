extends Node

@export var VWorkspace:Control;

var is_grabbing = false;
var grabbed_part = null;
var grab_ang = 0.0;

func _process(_delta):
	if is_grabbing: process_grab();

func grab_part(mp:Vector2, part:Node):
	var d = (part.position - mp).normalized();
	var ang = atan2(d.y, d.x);
	grab_ang = ang - part.rotation;
	grabbed_part = part;
	is_grabbing = true;

func ungrab_part():
	grab_ang = 0;
	grabbed_part = null;
	is_grabbing = false;
	
func process_grab():
	var mp = VWorkspace.get_local_mouse_position();
	var d = (grabbed_part.position - mp).normalized();
	var ang = atan2(d.y, d.x);
	grabbed_part.rotation = ang - grab_ang;
