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

	if global.events_allowed : #Si le mode event est actif
		if global.is_event_active():# si il y a des events actif dispos
			for i in global.events_active.size():
				global.events_active[i].time += 1;
				if ((randi() % 100) + 1 > 100 - global.events_active[i].time):
					var event = global.get_event_active(-1);
					var text_final = event.end
					if not event.players.empty():
						for j in event.players.size():
							text_final = text_final.format({ str(j): event.players[j] });
					set_text(text_final);
					global.remove_event(i);
					return "stop event";
		if $events.is_avalaible( global.get_players_size() ): # start a new event
			if ((randi() % 100) + 1 > 100 - time_since_last_event):
				time_since_last_event = 0;
				var event = $events.pick_event();
				var text_final = event.start;
				for i in event.players.size():
					text_final = event.start.format({ str(i): event.players[i] });
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
