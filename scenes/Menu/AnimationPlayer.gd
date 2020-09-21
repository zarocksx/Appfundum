extends AnimationPlayer

var isLobby = true

func _on_lobby_show_settings():
    show_settings()


func _on_lobby_show_mode():
    isLobby = false
    show_game_mode()


func _on_menu_pressed():
    if isLobby :
        show_menu()
    else :
        show_game_mode()


func _on_game_mode_settings():
    show_settings()


func _on_game_mode_menu():
    isLobby = true
    show_menu()


func show_game_mode():
    play("game_mode")



func show_menu():
    play("menu")


func show_settings():
    play("settings")

