extends Control


func _ready():
	var popup = $ThemePopup
	popup.popup_centered()
	self.visible = true


func _on_Close_pressed():
	if self.is_inside_tree():
		self.queue_free()
