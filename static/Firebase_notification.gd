extends Node


var remoteNotification


func _ready():
	if(Engine.has_singleton("FireBase")):
		remoteNotification = Engine.get_singleton("FireBase")