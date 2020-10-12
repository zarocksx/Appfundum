extends Control

func _ready():
	var popup = $ThemePopup
	popup.popup_centered()
	self.visible = true

func _on_Close_pressed():
	self.visible = false
	self.queue_free()
