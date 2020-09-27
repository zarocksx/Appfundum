extends Node

func _on_player_added():
	var player_box = get_node("lobby/ScrollContainer/VBoxContainer/PlayerNameBox");
	if (global.players.size()>1):
		player_box.is_ready();
		global.set_game_started();
	else:
		global.players = [];
		print("empty 2");
		player_box.not_ready();
	pass;