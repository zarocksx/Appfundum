extends LineEdit

func get_text_value():
	var myText = get_text();
	if (myText.length() > 1):
		global.add_players(myText)

	