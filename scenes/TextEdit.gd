extends TextEdit

var question := {
		"question": {},
		"author": {}
	}

func _on_ajouter_pressed():
	if text.empty():
		print("question empty");
		return;
	print(firebase.user_info.id);
	question.question = {"stringValue" : text};
	question.author = {"stringValue" : firebase.user_info.id};

	firebase.save_document("question",question);
	pass;
