extends TextureButton
signal addPlayer

var playerName

func _on_AddPlayerInput_text_changed(new_text):
	playerName = get_node("..").text


func _on_TextureButton_pressed():
	emit_signal("addPlayer", playerName)
