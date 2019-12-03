extends Label

var line_ready = false;
var cercles_ready = false

func _ready():
	pic_line();
	pass;

func _on_Button_pressed():
	pic_line();
	pass;

# P = player | C = cercle | S = second player
func pic_line():
	if (line_ready && cercles_ready) == false :
		line_ready = $json.load_data();
		cercles_ready = $cercles.load_data();
	var P = global.random_player();
	var S = global.random_player();
	while S == P:
		randomize();
		S = global.random_player();
	var text_final = $json.pick_one();
	text_final = text_final.format({"P": P});
	text_final = text_final.format({"S": S});
	text_final = text_final.format({"C": $cercles.pick_one()});
	set_text(text_final);
	pass
