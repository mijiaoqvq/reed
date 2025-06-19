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
	if not first:
		%Necrass.reed = reed

var scene : AsyncScene
func _on_balloon_finished() -> void:
	%Balloon.fade()
	if end:
		scene = AsyncScene.new("res://scenes/end.tscn", AsyncScene.LoadingSceneOperation.ReplaceImmediate)

var first := true
func _on_boss_point_body_entered(body: Node3D) -> void:
	if body.is_in_group(&"player"):
		if first:
			first = false
			%Balloon.start(preload("uid://byw7ckotmg7mh"))
			%Necrass.reed = reed
	

func _on_necrass_dead() -> void:
	_end()
