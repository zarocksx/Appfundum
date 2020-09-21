extends TextureButton
signal addPlayer

var playerName

func _on_AddPlayerInput_text_changed(new_text):
	playerName = get_node("..").text


func _on_TextureButton_pressed():
	if playerName == " ":
		get_node("..").text = ""
		get_node("..").set_self_modulate(Color(1,0,0))
	else :
		get_node("..").set_self_modulate(Color(0,1,0))
		emit_signal("addPlayer", playerName)
