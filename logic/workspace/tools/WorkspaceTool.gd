extends Node
class_name WorkspaceTool

@export var n_tool:Node;
@export var VWorkspace:Node;
@export var CWorkspace:Node;

func on_event(event)->bool:
	if G.is_RMB_down(event): n_tool.clear(); return true;
	return false;

func clone(): pass
func shutdown(): pass
