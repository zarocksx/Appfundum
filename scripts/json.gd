extends Node

export var LINES = 'res://assets/data/Appfundum.json';
export var limited = false;
export var event = false;
var events;
var unreadString = [];
var alreadyReadString = [];

func load_data() -> bool:
	var data = File.new();
	if not data.file_exists(LINES):
		return false;

	data.open(LINES, File.READ);
	unreadString = parse_json(data.get_as_text());
	if event :
		events = JSON.parse(data.get_as_text());
		print( events.result["0"].events.front().start );
	
	return true;

func pick_sentence() -> String:
	randomize();
	if not is_finish() :
		var mySeed = randi() % ( unreadString.size() );
		var sentence = unreadString[mySeed];
		if limited :
			alreadyReadString.push_front(sentence);
			unreadString.remove(mySeed);
		return sentence;
	global.set_game_finished();
	return 'Partie terminée !';

func pick_event():
	var players = global.get_players(-1);
	randomize();
	players.shuffle();

	print("pick event");
	print(events.result["0"].events[0].start);
	# TODO choose a random qty of player, then check if event of this category is valaible, if not choose an other qty of player
	print(global.players.size()-1);
	var index = str(randi()%global.players.size())
	if events.result[index].events.empty():
		return {};

	var event_picked = {
		"start" : str(events.result[index].events[0].start),
		"end" : str(events.result[index].events[0].end),
		"players" : players,
		"time" : 0
	}

	global.add_event(event_picked)
	return event_picked;

func is_avalaible(nPlayer: int):
	#print(nPlayer);
	return true;

func is_finish() -> bool:
	if global.get_game_state() == 2:
		global.back_to_menu();
		OS.set_screen_orientation(1);
	if unreadString.size() > 2 :
		return false;
	return true;
