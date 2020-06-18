extends Node

func _on_player_added():
	if (global.players.size()>0):
		global.set_game_started();
	else:
		global.players = [];
		print("empty 2");
		var player_box = get_node("lobby/ScrollContainer/VBoxContainer/PlayerNameBox");
		player_box.not_ready();
	pass;