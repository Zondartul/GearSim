extends PrimitiveCPart
class_name PartGear

var n_teeth = 32
var diameter = 10.0
var depth = 1.0
var viewmodel:Line2D = null;
var radius: get = get_radius;
const script_geometry = preload("res://logic/workspace/geometry.gd")

func _init():
	print("PartGear init, viewmodel = "+str(viewmodel));

func get_radius(): return diameter/2.0;

func _ready():
	for ch in get_children(): remove_child(ch); #remove previous viewmodel
	viewmodel = Line2D.new();
	print("PartGear ready, viewmodel = "+str(viewmodel));
	add_child(viewmodel);
	update();

func update():
	script_geometry.gen_gear(viewmodel, n_teeth, diameter, depth);
	print("PartGear updated")

func clone():
	var res = super.clone();
	G.copy_params(self, res, ["n_teeth", "diameter", "depth"]);
	#res.viewmodel = res.viewmodel.duplicate();
	return res;

func shutdown():
	viewmodel.queue_free();
	print("PartGear shutdown");
