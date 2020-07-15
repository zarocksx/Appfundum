extends Node

var players = [];
var game_state = 0; # 0 = in menu / 1 = in progress / 2 = finished
var events_allowed = true;
var events_active = [];
var game = preload("res://scenes/game.tscn");
var menu = preload("res://scenes/menu.tscn");
var turn = 0

func add_players(player):
	players.push_front(player);

func get_players(pos):
	if pos == -1 :
		return players;
	return players[pos];

func get_players_size():
	if players.empty():
		return 0;
	return players.size();

func get_random_player():
	return get_players(randi() % players.size() );

# TODO refactor name in get switched orientation
func get_view_landscape(): 
	var screen = get_viewport().get_visible_rect().size;
	return Vector2(screen.y,screen.x);

func get_event_active(index: int):
	if index == -1:
		return events_active.front();
		pass
	return events_active[index];

func is_event_active() -> bool:
	if events_active.empty():
		return false;
	return true;

func get_game_state():
	return game_state;

func set_game_finished():
	game_state = 2;

func set_game_started():
	game_state = 1;
	turn = 0;
	print("start game");
	print(get_tree().change_scene_to(game));
	print("__________");
	analytics.start_timer();

func add_event(event):
	events_active.push_front(event);
	pass

func remove_event(index: int):
	events_active.remove(index);
	pass

func back_to_menu():
	print("back to menu");
	firebase.save_analytics();
	print(get_tree().change_scene_to(menu));
	print("_______");
	game_state = 0;
	players = [];

func change_background(random):
	if random :
		VisualServer.set_default_clear_color(Color(randf()/1.2,randf()/1.2,randf()/1.2,1.0));
	VisualServer.set_default_clear_color(Color(0.14,0.15,0.23,1.0));

func screen_metrics():
	print("                 [Screen Metrics]")
	print("            Display size: ", OS.get_screen_size())
	print("   Decorated Window size: ", OS.get_real_window_size())
	print("             Window size: ", OS.get_window_size())
	print("        Project Settings: Width=", ProjectSettings.get_setting("display/window/size/width"), " Height=", ProjectSettings.get_setting("display/window/size/height")) 
	print(OS.get_window_size().x)
	print(OS.get_window_size().y)
