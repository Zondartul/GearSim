extends Node

const class_WorkspaceItem = preload("res://logic/classes/WorkspaceItem.gd");
const class_ContraptionPart = preload("res://logic/classes/ContraptionPart.gd");
const class_PrimitiveCPart = preload("res://logic/classes/PrimitiveCPart.gd");
const class_PartGear = preload("res://logic/classes/Primitive/Gear.gd");

var items = []

signal sig_item_added;
signal sig_items_changed;

func clear():
	for item in items:
		item._queue_free()
	items = []
	sig_items_changed.emit(items);

func add_part(partname)->Node:
	var item = null;
	match(partname):
		"gear": item = PartGear.new();
		_ : push_error("unknown or unimplemented partname: ["+str(partname)+"]"); return;
	new_item(item);
	return item;

func new_item(node):
	items.append(node);
	add_child(node);
	sig_item_added.emit(node);
	sig_items_changed.emit(items);
	print("workspace_model: new item: "+str(node.name));
