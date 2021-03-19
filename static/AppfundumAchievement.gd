extends Node


var achievement_list = 'res://assets/data/Appfundum_achievement.json';
var user_achievement = 'user://Appfundum_achievement.json'
var achievements_file = File.new();
var base_file = File.new();
var achievements

onready var current_achievement_item = preload('res://scenes/customNode/Achievement/Achievement_item_vertical.tscn').instance();


func _ready():
	add_child(current_achievement_item)
	if not Is_file_integrity(): return "error"
	load_achievment()


func Is_file_integrity():
	if not base_file.file_exists(achievement_list):
		printerr("no base achievement found")
		return false
	if not achievements_file.file_exists(user_achievement):
		printerr("no save achievement found")
		base_file.open(achievement_list, File.READ)
		achievements_file.open(user_achievement, File.WRITE)
		achievements_file.store_string(base_file.get_as_text())
		base_file.close()
	achievements_file.close()
	
	return true


func show_current_achievement_item(title, desc, type = "default"):
	current_achievement_item.set_caption(title, desc)
	current_achievement_item.show(type)


func load_achievment():
	achievements_file.open(user_achievement, File.READ)
	achievements = parse_json(achievements_file.get_as_text())
	achievements_file.close()


func save_achievement():
	achievements_file.open(user_achievement, File.READ_WRITE);
	if achievements_file.is_open():
		achievements_file.store_string(to_json(achievements))
		achievements_file.close()


func increment_achievement(achievement_name, amount):
	if achievements.has(achievement_name):
		achievements[achievement_name].progress.value += amount
		check_step(achievement_name)
	else :
		push_warning("No archievement with this name found")


func check_step(achievement_name):
	if achievements[achievement_name].progress.value >= achievements[achievement_name].total.value and not achievements[achievement_name].total.done:
		var achievement = achievements[achievement_name].desc
		achievements[achievement_name].total.done = true
		show_current_achievement_item(achievement.name, achievement.desc)
	save_achievement()
