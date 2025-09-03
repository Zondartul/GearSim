extends Node
# This lib computes dinstances between parts in the workspace

@export var VWorkspace:Node;
@export var CWorkspace:Node;
const script_geometry = preload("res://logic/workspace/geometry.gd")

static func sort_part_dist(A:Node, B:Node, pos:Vector2):
	return (A.position - pos).length() < (B.position - pos).length();

static func sort_part_size(A:Node, B:Node):
	return script_geometry.get_line_size(A) < script_geometry.get_line_size(B);

static func filter_part_inside(A:Node, pos:Vector2):
	return (A.position-pos).length() < script_geometry.get_line_size(A);

static func filter_part_dist(A:Node, pos:Vector2, dist:float):
	return (A.position - pos).length() < dist;

func get_parts_by_distance(pos:Vector2)->Array:
	var res_parts = VWorkspace.parts.duplicate()
	res_parts.sort_custom(sort_part_dist.bind(pos));
	return res_parts;

func get_part_mouse_dist(part)->float:
	return (part.position - VWorkspace.get_local_mouse_position()).length();

func get_mouseover_part(pos:Vector2):
	var sorted_parts = VWorkspace.parts.duplicate();
	sorted_parts = sorted_parts.filter(filter_part_inside.bind(pos));
	sorted_parts.sort_custom(sort_part_size);
	if sorted_parts.size():
		return sorted_parts.front();
	return null;

func get_nearby_part(pos:Vector2, max_dist:float):
	var sorted_parts = VWorkspace.parts.duplicate();
	sorted_parts = sorted_parts.filter(filter_part_dist.bind(max_dist).bind(pos));
	sorted_parts.sort_custom(sort_part_dist.bind(pos));
	if sorted_parts.size(): 
		return sorted_parts.front();
	return null;
