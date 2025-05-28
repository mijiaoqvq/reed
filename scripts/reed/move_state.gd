extends LimboState


@export var model: AnimatedSprite3D
@export var move: GUIDEAction = preload("res://control/move.tres")
@export var attack: GUIDEAction = preload("res://control/attrack.tres")
@export var run: GUIDEAction = preload("res://control/run.tres")

func _enter():
	if move.value_axis_3d.x != 0:
		model.play("move")
	#print("move")

func _update(_delta: float) -> void:
	if run.value_bool:
		agent.target_velocity.x = agent.run_speed * move.value_axis_3d.x
		model.speed_scale = agent.run_speed
	else:
		agent.target_velocity.x = move.value_axis_3d.x
		model.speed_scale = 1
	if attack.value_bool:
		get_root().dispatch("attack")
	if move.value_axis_3d.y > 0 and agent.is_on_floor():
		get_root().dispatch("jump")
	if move.value_axis_3d.length_squared() == 0:
		get_root().dispatch(EVENT_FINISHED)

func _exit() -> void:
	model.speed_scale = 1
