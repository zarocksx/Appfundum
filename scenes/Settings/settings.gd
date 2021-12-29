extends Control


signal menu_pressed


func _on_menu_pressed():
	emit_signal("menu_pressed")
	AppfundumAchievement.increment_achievement("contributionFirst", 1)


func _on_Control_toggled(is_active):
	global.set_nudity(is_active)