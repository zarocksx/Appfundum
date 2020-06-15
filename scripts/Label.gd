extends Label

var line_ready = false;
var cercles_ready = false;
var events_ready = false;
var time_since_last_event = 0;

func _ready():
	pic_line();
	pass;

func _on_Button_pressed():
	randomize();
	time_since_last_event += 1;
	pic_line();
	pass;

# P = player | C = cercle | S = second player
func pic_line():

	if (line_ready && cercles_ready && events_ready) == false:
		line_ready = $json.load_data();
		cercles_ready = $cercles.load_data();
		events_ready = $events.load_data();

	if global.events_allowed :
		if global.is_event_active():
			for i in global.events_active.size():
				global.events_active[i].time += 1;
				if ((randi() % 100) + 1 > 100 - global.events_active[i].time):
					var text_final = global.events_active[i].end
					if not global.events_active[i].players.empty():
						for j in global.events_active[i].player.size():
							text_final = text_final.format({ str(j): global.events_active[i].player[j] });
					set_text(text_final);
					global.remove_event(i);
					return "stop event";
		if $events.is_avalaible( global.get_players_size() ) :
			if ((randi() % 100) + 1 > 100 - time_since_last_event):
				time_since_last_event = 0;
				var text_final = $events.pick_event()
				for i in range(global.get_players_size()):
					text_final = text_final.format({ str(i): global.get_players(i) });
				set_text(text_final);
				return "start event"

	var P = global.get_random_player();
	var S = global.get_random_player();

	while S == P:
		randomize();
		S = global.get_random_player();

	var text_final = $json.pick_sentence();
	text_final = text_final.format({"P": P});
	text_final = text_final.format({"S": S});

	text_final = text_final.format({"C": $cercles.pick_sentence()});

	set_text(text_final);
	return "question"
