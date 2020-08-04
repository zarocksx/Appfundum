extends AnimationPlayer

func _on_Button_pressed():
	if is_playing():
		self.stop(true);
	self.play("texte_start")


func _on_AddPlayerMenu_pressed():
	self.play("add_player_show")


func _on_TextureButton_addPlayer(player):
	self.play("add_player_hide")
	global.add_players(player)
