extends LimboState

@export var model: AnimatedSprite3D

func _enter():
	model.play("die")
	%AnimationPlayer.play("die")
	await %AnimationPlayer.animation_finished
	agent.queue_free()
