extends Node

var pause_count:= 0:
	set(value):
		pause_count = max(0, value)
		if pause_count > 0:
			get_tree().paused = true
		else:
			get_tree().paused = false
