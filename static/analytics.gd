extends Node

var game_timer = 0.00;
var question_played = [];
var curent_analytics = "";

var current_question := {
	"question_timer" : 0,
	"id" : ""
};

var fields := {
	"game_time_spend" : {},
	"turn" : {},
	"players" : {},
	"questions" : {}
};

func start_game_timer():
	game_timer = OS.get_ticks_msec();

func start_question_timer(id):
	if current_question.question_timer > 0.00 :
		current_question.question_timer = OS.get_ticks_msec() - current_question.question_timer
		question_played.push_back({
			"question_timer" : current_question.question_timer,
			"id" : current_question.id
		});
	
	current_question.id = id;
	current_question.question_timer = OS.get_ticks_msec();


func get_question_anl():
	var fields = {}
	var i = 0
	for question in question_played:
		print(question.id)
		var value = {
			"id" : {"stringValue": question.id },
			"timer" : {"integerValue": question.question_timer }
		}
		fields[str(i)] = { "mapValue" : {"fields" : value }}
		i = i+1

	return { "mapValue" : {"fields" : fields } }


func get_time_anl():
	return {"integerValue" : (OS.get_ticks_msec() - game_timer)}


func get_turn_anl():
	return { "integerValue" : global.turn }


func get_players_anl():
	var fields = {}
	var i = 0
	for player in global.players:
		fields[str(i)] = { "stringValue" : player }
		i = i + 1
	return { "mapValue" : { "fields" : fields } }


func get_analytics_fields():
	fields.game_time_spend = get_time_anl();
	fields.turn = get_turn_anl();
	fields.players = get_players_anl();
	fields.questions = get_question_anl();
	return fields;
