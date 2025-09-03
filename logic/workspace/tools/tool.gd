extends Node

@export var VWorkspace:Node;
const class_WorkspaceTool = preload("res://logic/workspace/tools/WorkspaceTool.gd")
const class_ToolPlaceGear = preload("res://logic/workspace/tools/tool_place_gear.gd")
var current_tool:WorkspaceTool = null;

func _ready():
	set_tool_by_name("none");

func set_tool(tool:WorkspaceTool):
	current_tool = tool;
	current_tool.n_tool = self;
	current_tool.VWorkspace = VWorkspace;
	add_child(current_tool);

func on_event(event):
	if current_tool: current_tool.on_event(event);

func set_tool_by_name(toolname:String):
	match toolname:
		"none": set_tool(WorkspaceTool.new())
		"place_gear": set_tool(ToolPlaceGear.new());
		"place_motor": pass;
		"place_link": pass;
		_: push_error("unknown tool");
