extends Node


func _notification(notif):
	if notif == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		# quitting app or back-button on Android
		if (global.get_game_state() > 0):
			firebase.save_analytics()
		get_tree().quit()
	if notif == MainLoop.NOTIFICATION_WM_FOCUS_OUT :
		# switched to different app
		push_warning("Switched app")
