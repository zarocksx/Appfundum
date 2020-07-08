extends Control

signal show_settings

func _ready():
	#firebase.anonymous_register();
	pass;

func _on_player_added():
	if (global.players.size()>0):
		global.set_game_started();
	else:
		global.players = [];
		print("empty 1");
		var player_box = get_node("ScrollContainer/VBoxContainer/PlayerNameBox");
		player_box.not_ready();
	pass;

func _on_settings_pressed():
	emit_signal("show_settings");
	pass

func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray):
	var response = JSON.parse(body.get_string_from_ascii());
	if response_code != 200 && response_code:
		print("error response : ",response_code);
		print(response.result)
	else:
		print("request completed : ");
		pass
	pass;
