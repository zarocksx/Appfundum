extends Control

signal show_settings
signal show_mode


func _ready():
	firebase.anonymous_register();


func _on_player_added():
	var player_box = get_node("ScrollContainer/VBoxContainer/PlayerNameBox");
	if (global.players.size()>1):
		player_box.is_ready();
		emit_signal("show_mode");
	else:
		global.players = [];
		player_box.not_ready();


func _on_settings_pressed():
	emit_signal("show_settings");


func _on_HTTPRequest_request_completed(_result: int, response_code: int, _headers: PoolStringArray, body: PoolByteArray):
	var _response = JSON.parse(body.get_string_from_ascii());
	if response_code != 200 and response_code:
		push_warning("error response : %d" % [response_code]);
