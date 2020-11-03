extends Timer


onready var game = preload("res://scenes/Game/game.tscn");


func _ready():
	get_tree().change_scene_to(game)
