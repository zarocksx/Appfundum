extends Popup


func _on_Close_pressed():
	AchievementManager.increment_achievement("randomAchievementExampleOne", 101);
	self.visible = false


func _on_Logo_pressed():
	#popup_centered()
	pass
