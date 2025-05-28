extends LimboState

@export var model: AnimatedSprite3D
@export var move: GUIDEAction = preload("res://control/move.tres")
@export var attack: GUIDEAction = preload("res://control/attrack.tres")

func _enter():
	model.play("idle")
	#print("idle")

func _update(_delta: float) -> void:
	if attack.value_bool:
		get_root().dispatch("attack")
	if move.value_axis_3d.length_squared() != 0:
		get_root().dispatch(EVENT_FINISHED)
