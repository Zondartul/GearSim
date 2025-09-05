extends WorkspaceItem
class_name ContraptionPart

var can_rotate = false
var can_slide = false
var rot = 0.0
var slide = 0.0

func clone():
	var res = super.clone();
	G.copy_params(self, res, ["can_rotate", "can_slide", "rot", "slide"]);
	return res;
