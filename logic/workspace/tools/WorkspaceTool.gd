extends Node
class_name WorkspaceTool

@export var n_tool:Node;
@export var VWorkspace:Node;

func on_event(event):
	if G.is_RMB_down(event): n_tool.clear();
