extends Node

export var save_dict = {}
export var players_name = [] # [ { name : "toto", seen : 6 }, ... ]
export var question_played = [] # [ { id : 0, seen : 31, time : [ 5, 32, 7, 8, ... ] }, ... ]
export var party_started = 0
export var time_played = [] # additionné on obtient le temps total de l'app active
export var when_played = [] # les heures auxquels le joueur joue (récuperer quand le joueur lance l'app)
export var save_path = "user://savegame.save"


func _ready():
	load_user_data()


func load_user_data():
	var save_file = File.new()
	if not save_file.file_exists(save_path):
		print("Save not found -> creating new save ...")
		save_user_data()
		print("new save created !")
		return

	save_file.open(save_path, File.WRITE_READ)


func save_user_data():
	var save_file = File.new()
	save_file.open(save_path, File.WRITE)

	save_dict = {
		"players_name" : get_player_list(),
		"question_played" : get_question_list(),
		"party_started" : get_count_party_started(),
		"time_played" : get_time_played(),
		"when_played" : get_when_played()
	}

	save_file.store_line(to_json(save_dict))
	save_file.close()


func reset_user_data():
	var dir = Directory.new()
	dir.remove(save_path)
	load_user_data()


func get_player_list():
	pass


func get_question_list():
	pass


func get_count_party_started():
	pass


func get_time_played():
	pass


func get_when_played():
	pass
