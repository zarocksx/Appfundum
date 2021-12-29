extends Control

signal show_settings
signal show_mode


func _ready():
	firebase.anonymous_register()


func _on_player_added():
	var player_box = get_node("ScrollContainer/VBoxContainer/PlayerNameBox")
	sanitize_duplicates()
	if (global.players.size()>1):
		player_box.is_ready()
		emit_signal("show_mode")
	else:
		global.players = []
		player_box.not_ready()

func sanitize_duplicates():
	for i in range(0, global.players.size()-1):
		for j in range(global.players.size()):
			print(global.players[j],global.players[i], global.players[j] == global.players[i] && i != j)
			if global.players[j] == global.players[i] && i != j:
				global.players.remove(i)


func _on_settings_pressed():
	emit_signal("show_settings")


func _on_HTTPRequest_request_completed(_result: int, response_code: int, _headers: PoolStringArray, body: PoolByteArray):
	var _response = JSON.parse(body.get_string_from_ascii())
	if response_code != 200 and response_code:
		push_warning("error response : %d" % [response_code])
