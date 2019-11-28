extends Node

func _on_player_added():
	print( global.players.size() );
	if (global.players.size()>0):
# warning-ignore:return_value_discarded
		global.set_game_started();
		get_tree().change_scene("res://scenes/game.tscn");
	else:
		print("not enought player");
		global.players = [];
		var player_box = get_node("UI/ScrollContainer/VBoxContainer/PlayerNameBox");
		player_box.not_ready();
	pass;