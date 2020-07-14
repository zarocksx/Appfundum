extends Node

func _notification(notif):
	if notif == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		# quitting app or back-button on Android
		print("exit")
		if (global.get_game_state() > 0):
			firebase.save_time();
			print("time saved")
		get_tree().quit()
	if notif == MainLoop.NOTIFICATION_WM_FOCUS_OUT :
		# switched to different app
		print("switch app")
	pass

