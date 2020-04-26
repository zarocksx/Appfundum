extends AnimationPlayer

func _on_lobby_show_settings():
    show_settings();

func _on_menu_pressed():
    show_menu()

func show_menu():
    print("menu")
    play("menu");

func show_settings():
    play("settings");



