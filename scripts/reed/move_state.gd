extends LimboState


@export var model: AnimatedSprite3D
@export var move: GUIDEAction = preload("res://control/move.tres")
@export var jump: GUIDEAction = preload("res://control/jump.tres")
@export var attack: GUIDEAction = preload("res://control/attack.tres")
@export var remote_attack: GUIDEAction = preload("res://control/remote_attack.tres")
@export var run: GUIDEAction = preload("res://control/run.tres")

var need_jump := false

func _ready() -> void:
	jump.triggered.connect(_on_jump_triggered)
	
func _on_jump_triggered():
	if is_active():
		need_jump = true

func _enter():
	if move.value_axis_3d.x != 0:
		model.play("move")
	else:
		agent.target_velocity = Vector3(0,0,0)
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
	if remote_attack.value_bool:
		get_root().dispatch("remote_attack")
	if need_jump and agent.is_on_floor():
		get_root().dispatch("jump")
	need_jump = false
	if move.value_axis_3d.length_squared() == 0:
		get_root().dispatch(EVENT_FINISHED)

func _exit() -> void:
	model.speed_scale = 1
