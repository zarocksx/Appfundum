extends Control

signal settings
signal menu

func _on_Fossile_pressed():
	global.gameMode = 0
	global.set_game_started();
	


func _on_ACS_pressed():
	global.gameMode = 2
	global.set_game_started();


func _on_back_pressed():
	emit_signal("menu");


func _on_settings_pressed():
	emit_signal("settings");
