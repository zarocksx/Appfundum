extends Control

signal menu_pressed;

func _on_menu_pressed():
    emit_signal("menu_pressed");
    pass;