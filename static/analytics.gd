extends Node

var start_timer = 0.00;

var fields := {
	"game_time_spend" : {},
	"turn" : {},
	"players" : {}
}

func start_timer():
	start_timer = OS.get_ticks_msec()

func get_time_anl():
	return {"integerValue" : (OS.get_ticks_msec() - start_timer)}

func get_turn_anl():
	return {"integerValue" : global.turn }

func get_players_anl():
	var fields = {}
	var i = 0
	for player in global.players:
		fields[str(i)] = {"stringValue": player }
		i = i+1
	print(fields)
	return { "mapValue" : {"fields" : fields } }

func get_analytics_fields():
	fields.game_time_spend = get_time_anl();
	fields.turn = get_turn_anl();
	fields.players = get_players_anl();
	return fields;

