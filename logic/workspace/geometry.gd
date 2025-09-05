extends Node

# also look at using built-in draw_circle()
static func gen_circle(line:Line2D):
	line.clear_points();
	var n_sides = 32;
	var r = 1.0;
	line.width = 1.0;
	for i in range(n_sides+1):
		var th = 2*PI*i/float(n_sides);
		var x = r*cos(th);
		var y = r*sin(th);
		line.add_point(Vector2(x,y));

static func get_line_size(line:Line2D):
	var max_r = 0.0;
	for p in line.points:
		max_r = max(max_r, p.length());
	return max_r;

static func resize_line(line:Line2D, new_size:float):
	var max_r = get_line_size(line);
	for i in range(line.get_point_count()):
		var p = line.points[i];
		line.set_point_position(i,p*new_size/max_r);

#--- gear stuff ---

static func gen_gear(line:Line2D, n_teeth, diameter, depth):
	# generate a 2D gear outline
	line.clear_points();
	line.width = 1.0;
	var pitch = 2*PI/float(n_teeth);
	print("pitch = "+str(pitch))
	var profile = gen_tooth_profile(pitch, diameter, depth);
	for i in range(n_teeth):
		var round_prof = map_to_circle(profile,i*pitch);
		for p in round_prof:
			line.add_point(p);

static func gen_tooth_profile(pitch, diameter, depth)->Array:
	var r = diameter/2.0;
	var point_coords = [[0.0,-1.0],[1.0/4.0,-1.0],[2.0/4.0,+1.0],[3.0/4.0,+1.0],[1.0,-1.0]];
	var points_polar = [];
	for p in point_coords:
		var x = pitch*p[0];
		var y = r + (depth/2.0)*p[1];
		var pp = Vector2(x,y);
		points_polar.push_back(pp);
	return points_polar;

static func map_to_circle(points:Array, ang_offset)->Array:
	var res_points = []
	for p in points:
		var th = p[0] + ang_offset
		var r = p[1]
		var x = r*cos(th)
		var y = r*sin(th)
		res_points.append(Vector2(x,y))
	return res_points;

#--- end gear stuff
