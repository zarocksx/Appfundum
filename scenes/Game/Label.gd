extends Label

var line_ready = false;
var cercles_ready = false;
var events_ready = false;
var time_since_last_event = 0;

var debugCall = 0

func _ready():
	checkJson()
	pic_line(); # affiche la première sentence
	pass;


func _on_Button_pressed():
	if self.visible :
		randomize();
		pic_line();
		debugCall = 0


func pic_line():
	globalTheme.setBackgroundColor();

	if global.events_allowed : #Si le mode event est actif
		time_since_last_event += 1;
		if global.is_event_active():# si il y a des events actif dispos
			if event_stop() : return "event_stop";
		if event_start() : return 'event_start';

	set_sentence();
	return "sentence"


func event_stop():
	for i in global.events_active.size():
		global.events_active[i].time += 1;
		if ((randi() % 100) + 1 > 100 - global.events_active[i].time):
			var event = global.get_event_active(-1);
			var text_final = event.end;
			if not event.players.empty():
				for j in event.players.size():
					text_final = text_final.format({ str(j): event.players[j] });
			set_text(text_final);
			VisualServer.set_default_clear_color(Color(randf()/1.3,randf()/1.3,randf()/1.3,1.0))
			global.remove_event(i);
			return true;


func event_start():
	if ((randi() % 100) + 1 > (100 - time_since_last_event) ): #augmente les probabilitée de demmarrer un event
		time_since_last_event = 0;
		var event = $events.pick_event();
		if event :
			var text_final = event.start;
			var selectedPlayer
			print("event picked")
			for i in event.players.size():
				selectedPlayer = event.players[i]
				
				text_final = text_final.format({ str(i+1): selectedPlayer });
				print('players :' , i)
				print(text_final)
			print('player name',selectedPlayer)
			
			VisualServer.set_default_clear_color(Color(randf()/1.3,randf()/1.3,randf()/1.3,1.0));
			set_text(text_final);
		return true


func set_sentence():
	var P = global.get_random_player();
	var S = global.get_random_player();

	while S == P:
		randomize();
		S = global.get_random_player();

	var text_final = $json.pick_sentence();
	text_final = text_final.format({"P": P}); # P = player
	text_final = text_final.format({"S": S}); # S = second player

	text_final = text_final.format({"C": $cercles.pick_sentence()}); # C = cercle
	
	global.next_turn()
	set_text(text_final);
	return "question"


func checkJson():
	if (line_ready && cercles_ready && events_ready) == false: # vérifie que les Json sont bien load
		line_ready = $json.load_data();
		cercles_ready = $cercles.load_data();
		events_ready = $events.load_data();

	pass
