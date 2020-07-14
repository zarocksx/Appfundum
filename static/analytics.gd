extends Node

var start_timer = 0.00;

var time := {
	"game_time_spend": {}
}

func start_timer():
	start_timer = OS.get_ticks_msec()

func get_time_spend():
	time.game_time_spend = {"integerValue" : (OS.get_ticks_msec() - start_timer)}
	return time
