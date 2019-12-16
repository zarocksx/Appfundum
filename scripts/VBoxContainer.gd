extends VBoxContainer

signal player_added;

var label = load("res://scenes/customNode/customEdit.tscn");

func _on_TextureButton_pressed():
	var playerLabel = label.instance();
	add_child(playerLabel);
	pass

func _on_start_pressed():
	for child in get_children():
		child.get_text_value();
	emit_signal("player_added");
	print("go");

func not_ready() -> void:
	for child in get_children():
		child.set_self_modulate(Color(1,0,0));
	
