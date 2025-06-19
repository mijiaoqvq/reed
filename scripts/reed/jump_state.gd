extends LimboState

@export var model: AnimatedSprite3D
@export var move: GUIDEAction = preload("res://control/move.tres")
@export var attack: GUIDEAction = preload("res://control/attack.tres")
@export var remote_attack: GUIDEAction = preload("res://control/remote_attack.tres")
@export var jump: GUIDEAction = preload("res://control/jump.tres")

var need_jump := false

func _ready() -> void:
	jump.triggered.connect(_on_jump_triggered)
	
func _on_jump_triggered():
	if is_active():
		need_jump = true

func _enter():
	model.play("idle")
	agent.target_velocity.y = agent.speed_y

func _update(_delta: float) -> void:
	if attack.value_bool:
		get_root().dispatch("attack")
	if remote_attack.value_bool:
		get_root().dispatch("remote_attack")
	if agent.is_on_floor():
		get_root().dispatch(EVENT_FINISHED)
	if need_jump and agent.is_on_wall() and not agent.is_on_floor():
		get_root().dispatch("jump")
	need_jump = false
