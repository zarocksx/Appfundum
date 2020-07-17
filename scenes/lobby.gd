extends Control

signal show_settings

func _ready():
	firebase.anonymous_register();
	if(Engine.has_singleton("GodotLocalNotification")):
		var ln = Engine.get_singleton("GodotLocalNotification")

		var message = "Hello ..!!"+ str(OS.get_time())
		var interval = 10 # 1 minute
		var tag = 2 # tag is 2
		ln.show_local_notification(message,"My title 1",interval,tag)
		print("start notification")
	pass;

func _on_player_added():
	if (global.players.size()>0):
		global.set_game_started();
	else:
		global.players = [];
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
	else:
		print("request completed : ");
		pass
	pass;
