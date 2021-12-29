extends VBoxContainer


signal player_added

var label = load("res://scenes/customNode/CustomEdit/customEdit.tscn")


func _on_TextureButton_pressed():
	var playerLabel = label.instance()
	add_child(playerLabel)


func _on_start_pressed():
	for child in get_children():
		if child is LineEdit :
			child.get_text_value()
	emit_signal("player_added")


func not_ready():
	for child in get_children():
		child.set_self_modulate(Color(1,0,0))


func is_ready():
	for child in get_children():
		child.set_self_modulate(Color(1,1,1))
