extends Control

signal show_settings

func _on_player_added():
	print("called");
	print( global.players.size() );
	if (global.players.size()>0):
		global.set_game_started();
	else:
		print("not enought player");
		global.players = [];
		var player_box = get_node("ScrollContainer/VBoxContainer/PlayerNameBox");
		player_box.not_ready();
	pass;



func _on_settings_pressed():
	emit_signal("show_settings");
	pass # Replace with function body.
