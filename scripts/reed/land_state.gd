extends LimboState

@export var model: AnimatedSprite3D
@export var move: GUIDEAction = preload("res://control/move.tres")

func _enter():
	model.play("land")
	print("land")

func _update(_delta: float) -> void:
	if not model.is_playing():
		get_root().dispatch(EVENT_FINISHED)
