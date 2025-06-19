extends Scene

@export var skip_log : bool = false

func _start():
	if not skip_log:
		%Balloon.start(preload("uid://bqjubslcecjvo"))

var end := false

func _end():
	end = true
	%Balloon.start(preload("uid://fg35220g5ews"))
	
		
		
func back_to_checkpoint():
	super.back_to_checkpoint()

var scene : AsyncScene
func _on_balloon_finished() -> void:
	%Balloon.fade()
	if end:
		if scene == null:
			scene = AsyncScene.new("res://scenes/scene_3.tscn", AsyncScene.LoadingSceneOperation.ReplaceImmediate)
