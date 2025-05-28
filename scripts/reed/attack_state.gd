extends LimboState

@export var model: AnimatedSprite3D

@export var attack_acc := 0.05

@export var attack_area : Area3D

var raw_acc: float

func _ready() -> void:
	model.animation_finished.connect(_on_attrack_end)

func _enter():
	model.play("attack", agent.attack_speed)
	if agent.is_on_floor():
		agent.velocity.x = 3 * sign(agent.target_velocity.x)
	else:
		agent.velocity.x = 5 * sign(agent.target_velocity.x)
	raw_acc = agent.acc
	agent.acc = attack_acc
	#print("attack")
	
func _update(delta: float) -> void:
	attack_area.monitoring = model.frame > 50 and model.frame < 150

func _on_attrack_end():
	get_root().dispatch(EVENT_FINISHED)

func _exit() -> void:
	agent.acc = raw_acc
