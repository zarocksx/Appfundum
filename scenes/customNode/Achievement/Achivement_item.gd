extends Panel


onready var tween = $Tween
onready var timer = $Timer
onready var style = load("res://assets/theme/AchievmentStyle.tres")
onready var title = $MarginContainer/HBoxContainer/Title setget set_title, get_title
onready var description = $MarginContainer/HBoxContainer/Title setget set_description, get_description

export var isHorizontal = false
var slide_distance = 0


func _ready():
	slide_distance += rect_size.y * 2


func set_title(new_title):
	title.text = new_title.to_lower()


func set_description(new_description):
	description.text = new_description.to_lower()


func set_style():
	var color1 = themeStore.getThemeValues(themeStore.getCurrentTheme()).main
	var color2 = themeStore.getThemeValues(themeStore.getCurrentTheme()).secondary
	style.set_bg_color(Color(color1))
	style.set_border_color(Color(color2))


func get_title():
	return title.text


func get_description():
	return description.text


func show():
	set_style()
	var final_position
	var initial_position = rect_position
	final_position = rect_position + Vector2(0, slide_distance)
	var tween_duration = 0.5
	tween.interpolate_property(self, "rect_position", initial_position, final_position,
			tween_duration, tween.TRANS_BACK, tween.EASE_OUT)
	tween.start()
	yield(tween, "tween_completed")
	timer.start()


func hide():
	var initial_position = rect_position
	var final_position
	final_position = rect_position - Vector2(0, slide_distance)
	var tween_duration = 0.5
	tween.interpolate_property(self, "rect_position", initial_position, final_position,
			tween_duration, tween.TRANS_BACK, tween.EASE_IN)
	tween.start()
	yield(tween, "tween_completed")
