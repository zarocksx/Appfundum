extends Node
onready var current_achievement_item = preload('res://scenes/customNode/Achievement/Achievement_item_vertical.tscn').instance();
var achievement_list = 'res://assets/data/Appfundum_achievement.json';

var achievements


func _ready():
	add_child(current_achievement_item)
	load_achievment()


func show_current_achievement_item(title, desc):
	current_achievement_item.set_caption(title, desc)
	current_achievement_item.show()


func load_achievment():
	var achievements_file = File.new();
	if not achievements_file.file_exists(achievement_list):
		printerr("no Achievement found", achievement_list)
		return false;
	achievements_file.open(achievement_list, File.READ);
	achievements = parse_json(achievements_file.get_as_text());
	print(achievements)
	achievements_file.close()
	return true;


func save_achievement():
	var achievements_file = File.new();
	if not achievements_file.file_exists(achievement_list):
		printerr("no Achievement found", achievement_list)
		return false;
	achievements_file.open(achievement_list, File.READ_WRITE);
	if achievements_file.is_open():
		achievements_file.store_string(to_json(achievements))
		achievements_file.close()



func increment_achievement(achievement_name, amount):
	if achievements.has(achievement_name):
		achievements[achievement_name].progress.value += amount
		check_step(achievement_name)
	else :
		print("no archievement with this name")


func check_step(achievement_name):
	if achievements[achievement_name].progress.value >= achievements[achievement_name].total.value && not achievements[achievement_name].total.done:
		var achievement = achievements[achievement_name].desc
		achievements[achievement_name].total.done = true
		show_current_achievement_item(achievement.name, achievement.desc)
	save_achievement()
