extends Panel

var parts = [];
var part_scale = 10.0;

func _on_model_sig_item_added(node) -> void:
	var v:Node2D = node.viewmodel;
	v.scale.x = part_scale; 
	v.scale.y = part_scale;
	v.position = get_rect().get_center(); 
	add_child(v);
	print("workspace_view added_item");
