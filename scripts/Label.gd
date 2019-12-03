extends Label

var line_ready = false;
var cercles_ready = false

func _ready():
	pic_line();
	pass;

func _on_Button_pressed():
	pic_line();
	pass;

func pic_line():
	if (line_ready && cercles_ready) == false :
		line_ready = $json.load_data();
		cercles_ready = $cercles.load_data();
	var text_final = $json.pick_one();
	text_final = text_final.format({"P": global.random_player()});
	text_final = text_final.format({"C": $cercles.pick_one()});
	set_text(text_final);
	pass
