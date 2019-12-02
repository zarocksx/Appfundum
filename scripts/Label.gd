extends Label
var ready = false
func _ready():
	#set_size(global.get_view_landscape());
	ready = $json.load_data();
	set_text($json.pick_one());
	pass;

func _on_Button_pressed():
	if not ready :
		ready = $json.load_data();
	var text_Brut = $json.pick_one()
	var text_final = text_Brut.format({"P": global.random_player()})
	set_text(text_final);
	pass;