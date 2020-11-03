extends TextEdit


var question := {
		"question": {},
		"author": {}
	}

	
func _on_ajouter_pressed():
	if text.empty():
		printerr("Question list empty")
		return;
	question.question = {"stringValue": text}
	question.author = {"stringValue": firebase.user_info.id}

	firebase.save_document("question",question)
	var hint = get_node('../RichTextLabel')
	hint.visible = true
