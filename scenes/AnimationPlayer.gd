extends AnimationPlayer

func _on_settings_pressed():
    show_settings();

func _on_menu_pressed():
    show_menu()

func show_menu():
    play("menu");

func show_settings():
    play("settings");



