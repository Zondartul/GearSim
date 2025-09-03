extends Node
class_name PartGear

var n_teeth = 32
var diameter = 10.0
var depth = 1.0
@export var viewmodel:Line2D = null;
const script_geometry = preload("res://logic/workspace/geometry.gd")

func _init():
	viewmodel = Line2D.new();

func _ready():
	print("PartGear ready")
	update();

func update():
	script_geometry.gen_gear(viewmodel, n_teeth, diameter, depth);
	print("PartGear updated")
