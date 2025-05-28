extends LimboState

@export var model: AnimatedSprite3D
@export var move: GUIDEAction = preload("res://control/move.tres")
@export var attack: GUIDEAction = preload("res://control/attrack.tres")

func _enter():
	model.play("idle")
	agent.target_velocity.y = agent.speed_y

func _update(_delta: float) -> void:
	if attack.value_bool:
		get_root().dispatch("attack")
	if agent.is_on_floor():
		get_root().dispatch(EVENT_FINISHED)
