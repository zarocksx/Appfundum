extends Node


export var LINES = 'res://assets/data/Appfundum.json';
export var question = false
export var limited = false;
export var event = false;
var events;
var unreadString = [];
var alreadyReadString = [];
const EVENT_MAX_QTE = 3 + 1 # biggest key +1


func load_data():
	var data = File.new()
	if not data.file_exists(LINES):
		printerr("no files ( %s )", LINES)
		return false

	data.open(LINES, File.READ)
	unreadString = parse_json(data.get_as_text())

	if event:
		events = JSON.parse(data.get_as_text())
		for i in range(EVENT_MAX_QTE):
			if 	events.result.has(str(i)) and i >= global.players.size():
				events.result.erase(str(i))
	return true


func pick_sentence():
	randomize();
	if not is_finish():
		var mySeed = randi() % ( unreadString.size() )
		var sentence = unreadString[mySeed].sentence

		if question :
			while (unreadString[mySeed].category > global.gameMode):
				unreadString.remove(mySeed)
				if is_finish():
					global.set_game_finished()
					return 'Partie terminée !'
				randomize()
				mySeed = randi() % ( unreadString.size() )
				sentence = unreadString[mySeed].sentence

			analytics.start_question_timer(unreadString[mySeed].id)

		if limited:
			alreadyReadString.push_front(sentence)
			unreadString.remove(mySeed)
			

		return sentence

	global.set_game_finished()
	return 'Partie terminée !'


func pick_event():
	if events.result.empty():
		return false
	var players = global.get_players(-1)
	randomize()
	players.shuffle()
	var index = randi()%global.players.size()

	if (index > 0):
		index = index % EVENT_MAX_QTE
	index = str(index)

	while(!events.result.has(index)):
		randomize()
		index = (randi()%global.players.size())
		if (index > 0):
			index = index % EVENT_MAX_QTE
		index = str(index)

		if events.result.has(index):
			if events.result[index].events.empty():
				printerr("Events list is empty")
				events.result.erase(index)

		if events.result.empty():
			return false

	
	if( events.result[index].events.size() == 0):
		events.result.erase(index)
		return false

	var event_index = randi() % (events.result[index].events.size())
	var event_picked = {
		"start": str(events.result[index].events[event_index].start),
		"end": str(events.result[index].events[event_index].end),
		"players": players,
		"time": 0
	}

	events.result[index].events.remove(event_index)
	events.result[index].erase(index)
	global.add_event(event_picked)
	return event_picked;


func is_finish():
	if global.get_game_state() == 2:
		global.back_to_menu()
		OS.set_screen_orientation(1)
	if unreadString.size() > 2:
		return false
	return true
