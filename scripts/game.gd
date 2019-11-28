extends Control
func _ready():
	randomize();
	OS.set_screen_orientation(0);
	rect_size = global.get_view_landscape();
	print("info")
	print(global.get_view_landscape())
	print(OS.get_screen_size());

	pass # Replace with function body.

func _on_Button_pressed():
	print('touch screen');
	pass;
