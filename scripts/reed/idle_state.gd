extends LimboState

@export var model: AnimatedSprite3D
@export var move: GUIDEAction = preload("res://control/move.tres")
@export var jump: GUIDEAction = preload("res://control/jump.tres")
@export var attack: GUIDEAction = preload("res://control/attack.tres")
@export var remote_attack: GUIDEAction = preload("res://control/remote_attack.tres")

func _enter():
	model.play("idle")
	#print("idle")

func _update(_delta: float) -> void:
	if attack.value_bool:
		get_root().dispatch("attack")
	if remote_attack.value_bool:
		get_root().dispatch("remote_attack")
	if move.value_axis_1d != 0:
		get_root().dispatch(EVENT_FINISHED)
	if jump.value_axis_1d != 0:
		get_root().dispatch("jump")
