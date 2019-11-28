extends Node

var SAVE_PATH = 'res://assets/data/Appfundum.json';
var unreadString = [];
var alreadyReadString = [];

func _ready():
	print('json_ready');
	pass # Replace with function body.

func load_data():

	var data = File.new();
	if not data.file_exists(SAVE_PATH):
		return false;

	data.open(SAVE_PATH, File.READ);
	unreadString = parse_json(data.get_as_text());

	print(unreadString.size())
	return true;

func pick_one():
	randomize();
	if not is_finish() :
		var mySeed = randi() % ( unreadString.size() );
		var sentence = unreadString[mySeed];
		alreadyReadString.push_front(sentence);
		unreadString.remove(mySeed);
		return sentence;
	global.set_game_finished();
	return 'Partie terminée !';

func is_finish():
	if global.get_game_state() == 2:
		global.back_to_menu();
		OS.set_screen_orientation(1);
	if unreadString.size() > 2 :
		return false;
	return true;
