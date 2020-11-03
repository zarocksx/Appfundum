extends CanvasLayer


onready var panel = $Panel


func _ready():
	set_layer(999)


func set_caption(title, description):
	panel.set_title(title)
	panel.set_description(description)


func show():
	if global.game_state != 1:
		set_offset(Vector2(0,0))
		set_rotation_degrees(0)
		panel.show()
	else :
		set_offset(Vector2(1450, 600))
		set_rotation_degrees(90)
		panel.show()