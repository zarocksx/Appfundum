extends Node

export var LINES = 'res://assets/data/Appfundum.json';
export var limited = false;
var unreadString = [];
var alreadyReadString = [];

func load_data() -> bool:
	var data = File.new();
	if not data.file_exists(LINES):
		return false;

	data.open(LINES, File.READ);
	unreadString = parse_json(data.get_as_text());
	
	return true;

func pick_one() -> String:
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

func is_finish() -> bool:
	if global.get_game_state() == 2:
		global.back_to_menu();
		OS.set_screen_orientation(1);
	if unreadString.size() > 2 :
		return false;
	return true;
