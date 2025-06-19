extends Scene

@export var skip_log : bool = false

func _start():
	if not skip_log:
		%Balloon.start(preload("uid://ojet24vb73gx"))

var end := false

func _end():
	end = true
	%Balloon.start(preload("uid://7ekukjollayw"))
	
		
		
func back_to_checkpoint():
	super.back_to_checkpoint()

var scene : AsyncScene
func _on_balloon_finished() -> void:
	%Balloon.fade()
	if end:
		scene = AsyncScene.new("res://scenes/end.tscn", AsyncScene.LoadingSceneOperation.ReplaceImmediate)
