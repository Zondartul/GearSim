extends Node
class_name PartGear

var n_teeth = 32
var diameter = 10.0
var depth = 1.0
@export var viewmodel:Line2D = null;

func _init():
	viewmodel = Line2D.new();

func _ready():
	print("PartGear ready")
	update();

func update():
	gen_viewmodel();
	print("PartGear updated")

func gen_viewmodel():
	# generate a 2D gear outline
	var line = viewmodel;
	line.clear_points();
	line.width = 1.0;
	var pitch = 2*PI/float(n_teeth);
	print("pitch = "+str(pitch))
	var profile = gen_tooth_profile(pitch, diameter, depth);
	for i in range(n_teeth):
		var round_prof = map_to_circle(profile,i*pitch);
		for p in round_prof:
			line.add_point(p);
	#for p in profile: line.add_point(p);
	print("PartGear generated ["+str(line.name)+"]")
	#return line;
		
func gen_tooth_profile(pitch, diameter, depth)->Array:
	var r = diameter/2.0;
	var point_coords = [[0.0,-1.0],[1.0/4.0,-1.0],[2.0/4.0,+1.0],[3.0/4.0,+1.0],[1.0,-1.0]];
	var points_polar = [];
	for p in point_coords:
		var x = pitch*p[0];
		var y = r + (depth/2.0)*p[1];
		var pp = Vector2(x,y);
		points_polar.push_back(pp);
	return points_polar;

func map_to_circle(points:Array, ang_offset)->Array:
	var res_points = []
	for p in points:
		var th = p[0] + ang_offset
		var r = p[1]
		var x = r*cos(th)
		var y = r*sin(th)
		res_points.append(Vector2(x,y))
	return res_points;
