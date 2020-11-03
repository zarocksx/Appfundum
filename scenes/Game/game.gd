extends Control


func _ready():
	randomize();
	var anim = $'Label/AnimationPlayer'
	anim.play("add_player_hide")


func _on_Button_pressed():
	pass


func _on_AddPlayerInput_text_change_rejected():
	pass
