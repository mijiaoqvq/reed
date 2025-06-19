extends LimboState

@export var model: AnimatedSprite3D
@export var emit: Marker3D

const fireball_scene = preload("res://scenes/fireball.tscn")

func _ready() -> void:
	model.animation_finished.connect(_on_attack_end)

func _enter():
	model.play("attack2", agent.attack_speed)
	var fireball = fireball_scene.instantiate()
	add_child(fireball)
	fireball.global_position = emit.global_position
	fireball.rotation.y = PI if model.flip_h else 0
	fireball.speed *= -1 if model.flip_h else 1
	agent.sp -= 1
	#print(agent.sp)

func _on_attack_end():
	get_root().dispatch(EVENT_FINISHED)

func _exit() -> void:
	pass
