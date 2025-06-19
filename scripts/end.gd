extends Control

var scene : AsyncScene
func _on_button_pressed() -> void:
	if scene == null:
		scene = AsyncScene.new("res://scenes/main.tscn", AsyncScene.LoadingSceneOperation.ReplaceImmediate)
