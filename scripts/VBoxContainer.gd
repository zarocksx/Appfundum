
extends VBoxContainer

signal player_added;

var scene = load("res://scenes/customNode/customEdit.tscn");


func _on_TextureButton_pressed():
	var playerLabel = scene.instance();
	add_child(playerLabel);
	pass

func _on_start_pressed():
	for child in get_children():
		child.get_text_value();
	emit_signal("player_added");

func not_ready() -> void:
	for child in get_children():
		child.set_self_modulate(Color(1,0,0));
	
