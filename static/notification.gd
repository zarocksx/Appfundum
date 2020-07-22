extends Node

var localNotification = null
var tagCounter = 0;

func _ready():
	if(Engine.has_singleton("GodotLocalNotification")):
		localNotification = Engine.get_singleton("GodotLocalNotification")
	print("NOTIFICATION")


func addNotif( title = "", body = "", interval = 1):
	if localNotification != null:
		var tag = newTag()
		localNotification.show_local_notification(body,title,interval,tag)
		return tag
	return false


func stopNotif(id = -1):
	if localNotification != null:
		if id == -1:
			return localNotification.cancel_all()
		elif id == 0:
			return localNotification.stop_last_notification()
		else:
			return localNotification.cancel(id)
	return false


func newTag():
	tagCounter = tagCounter +1
	return tagCounter;
