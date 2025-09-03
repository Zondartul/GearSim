extends Node

func is_LMB_down(event): return (event is InputEventMouseButton) and (event.button_index == MOUSE_BUTTON_LEFT) and (event.pressed);
func is_LMB_up(event):  return (event is InputEventMouseButton) and (event.button_index == MOUSE_BUTTON_LEFT) and (not event.pressed);
func is_RMB_down(event): return (event is InputEventMouseButton) and (event.button_index == MOUSE_BUTTON_RIGHT) and (event.pressed);
func is_RMB_up(event):  return (event is InputEventMouseButton) and (event.button_index == MOUSE_BUTTON_RIGHT) and (not event.pressed);
