extends Node

var players = [];
var game_state = 0; # 0 = in menu / 1 = in progress / 2 = finished

func _ready():
	pass;

func add_players(player):
	players.push_front(player);

func get_players(pos):
	return players[pos];

func random_player():
	return get_players((randi()) % ( players.size() ) );

# TODO refactor name in get switched orientation
func get_view_landscape(): 
	var screen = get_viewport().get_visible_rect().size;
	return Vector2(screen.y,screen.x);

func get_game_state():
	return game_state;

func set_game_finished():
	game_state = 2;

func set_game_started():
	game_state = 1;
	get_tree().change_scene("res://scenes/Game.tscn");

func back_to_menu():
	game_state = 0;
	players = [];
	get_tree().change_scene("res://scenes/Menu.tscn");
	return true;

func screen_metrics():
	print("                 [Screen Metrics]")
	print("            Display size: ", OS.get_screen_size())
	print("   Decorated Window size: ", OS.get_real_window_size())
	print("             Window size: ", OS.get_window_size())
	print("        Project Settings: Width=", ProjectSettings.get_setting("display/window/size/width"), " Height=", ProjectSettings.get_setting("display/window/size/height")) 
	print(OS.get_window_size().x)
	print(OS.get_window_size().y)
