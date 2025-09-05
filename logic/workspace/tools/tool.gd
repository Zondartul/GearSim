extends Node
#Node: workspace->controller->tool
@export var VWorkspace:Node;
@export var CWorkspace:Node;
@export var MWorkspace:Node;
const class_WorkspaceTool = preload("res://logic/workspace/tools/WorkspaceTool.gd")
const class_ToolPlaceGear = preload("res://logic/workspace/tools/tool_place_gear.gd")
var current_tool:WorkspaceTool = null;

func _ready():
	set_tool_by_name("none");

func set_tool(tool:WorkspaceTool):
	current_tool = tool;
	current_tool.n_tool = self;
	current_tool.VWorkspace = VWorkspace;
	current_tool.CWorkspace = CWorkspace;
	add_child(current_tool);

func clear():
	current_tool.queue_free();
	current_tool = null;

func on_event(event)->bool:
	if current_tool: return current_tool.on_event(event);
	return false;

func set_tool_by_name(toolname:String):
	match toolname:
		"none": set_tool(WorkspaceTool.new())
		"place_gear": set_tool(ToolPlaceGear.new());
		"place_motor": pass;
		"place_link": pass;
		_: push_error("unknown tool");

func place_object(obj:WorkspaceItem):
	MWorkspace.add_object(obj);
