extends Control

signal show_settings

func _ready():
    firebase.anonymous_register(get_node("../HTTPRequest"));
    pass;

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


func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray):
    var response = JSON.parse(body.get_string_from_ascii());
    if response_code != 200:
        print("error response : ",response_code);
    else:
        print("request completed : ",response);
    pass # Replace with function body.
