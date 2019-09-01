extends Node

export (float) var R = 0.054
export (float) var G = 0.235
export (float) var B = 0.427

func _ready():
	VisualServer.set_default_clear_color(Color(R,G,B,1.0))

func _on_player_added():
	print( global.players );
	get_tree().change_scene("res://scenes/game.tscn")