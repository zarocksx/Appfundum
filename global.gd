extends Node

# Declare member variables here. Examples:
var players = [];
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_players(player):
	players.push_front(player);

func get_players(pos):
	return players[pos];

func random_player():
	return get_players((randi()+1) % ( players.size() ) );
