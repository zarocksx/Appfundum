extends Control

signal show_settings
signal show_mode

func _ready():
	firebase.anonymous_register();


func _on_player_added():
	if (global.players.size()>0):
		emit_signal("show_mode");
	else:
		global.players = [];
		var player_box = get_node("ScrollContainer/VBoxContainer/PlayerNameBox");
		player_box.not_ready();


func _on_settings_pressed():
	emit_signal("show_settings");


func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray):
	var response = JSON.parse(body.get_string_from_ascii());
	if response_code != 200 && response_code:
		print("error response : ",response_code);
	else:
		print("request completed : ");
