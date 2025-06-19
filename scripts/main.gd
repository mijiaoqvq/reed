extends Control

var scene : AsyncScene

func _on_start_pressed() -> void:
	scene = AsyncScene.new("res://scenes/scene_1.tscn", AsyncScene.LoadingSceneOperation.ReplaceImmediate)
	%Start.disabled = true
