extends LineEdit


func get_text_value():
	var myText = get_text()
	if (myText.length() > 1):
		global.add_players(myText)


func set_style(color,subColor = Color(0,0,0,0)):
	var style = load("res://assets/theme/textInput.tres")
	style.set_bg_color(color)
	style.set_border_color(subColor)