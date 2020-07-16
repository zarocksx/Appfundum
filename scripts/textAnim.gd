extends AnimationPlayer

func _on_Button_pressed():
	if is_playing():
		self.stop(true);
	self.play("texte_start")
