extends LimboState


@export var model: AnimatedSprite3D
@export var move: GUIDEAction = preload("res://control/move.tres")

func _enter():
	model.play("idle")
	agent.target_velocity.y = agent.speed_y
	agent.target_velocity.x = (1 if model.flip_h else -1) * max(abs(agent.target_velocity.x), 1)
	get_root().dispatch(EVENT_FINISHED)
