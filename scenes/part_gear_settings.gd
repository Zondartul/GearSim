extends Panel

var model:PartGear;

func _on_slider_diameter_value_changed(_value: float) -> void: write_to_model();
func _on_slider_depth_value_changed(_value: float) -> void: write_to_model();
func _on_spinner_teeth_value_changed(_value: float) -> void: write_to_model();

func write_to_model():
	var diameter = $B/GC/slider_diameter.value;
	var depth = $B/GC/slider_depth.value;
	var num_teeth = $B/GC/spinner_teeth.value;
	model.diameter = diameter;
	model.depth = diameter*(depth/100.0);
	model.n_teeth = num_teeth;
	model.update();
	print("set gear to ["+str(diameter)+" mm, "+str(depth)+"%, "+str(num_teeth)+"n]");
