extends CharacterBody3D

@export var move: GUIDEAction = preload("res://control/move.tres")
@export var camera_position :Node3D
@export var model: AnimatedSprite3D
@export var attack_area: Area3D

@export var hsm: LimboHSM
@export var idle_state: LimboState
@export var move_state: LimboState
@export var jump_state: LimboState
@export var jump_wall_state: LimboState
@export var attack_state: LimboState
@export var remote_attack_state: LimboState
@export var die_state: LimboState

@export var raw_acc:= 0.5
@export var raw_attack_speed:= 2.0
@export var raw_speed_x := 1.0
@export var raw_run_speed := 2.5
@export var raw_speed_y := 5.0
@export var raw_sp_rate := 0.4

var acc:= 0.5
var attack_speed:= 2.0
var speed_x := 1.0
var run_speed := 2.5
var speed_y := 5.0


signal status_change(Node)
signal need_camera_noise
signal die

var target_velocity : Vector3

@export var max_hp := 5:
	set(value):
		max_hp = value
		status_change.emit(self)
@export var hp := 5:
	set(value):
		value = clamp(value, 0, max_hp)
		if hp != 0 and value == 0:
			hsm.change_active_state(die_state)
			die.emit()
		hp = value
		
		status_change.emit(self)
		
			
@export var max_sp := 3.0:
	set(value):
		max_sp = value
		status_change.emit(self)
@export var sp := 3.0:
	set(value):
		sp = value
		status_change.emit(self)

func _ready() -> void:
	GUIDE.enable_mapping_context(preload("res://control/mapping_context.tres"))
	
	hsm.add_transition(idle_state, move_state, idle_state.EVENT_FINISHED)
	hsm.add_transition(idle_state, jump_state, "jump")
	hsm.add_transition(move_state, idle_state, move_state.EVENT_FINISHED)
	hsm.add_transition(move_state, jump_state, "jump")
	hsm.add_transition(jump_state, move_state, jump_state.EVENT_FINISHED)
	hsm.add_transition(idle_state, attack_state, "attack")
	hsm.add_transition(move_state, attack_state, "attack")
	hsm.add_transition(jump_state, attack_state, "attack")
	hsm.add_transition(idle_state, remote_attack_state, "remote_attack")
	hsm.add_transition(move_state, remote_attack_state, "remote_attack")
	hsm.add_transition(jump_state, remote_attack_state, "remote_attack")
	hsm.add_transition(jump_state, jump_wall_state, "jump")
	hsm.add_transition(jump_wall_state, jump_state, jump_wall_state.EVENT_FINISHED)
	hsm.add_transition(attack_state, move_state, attack_state.EVENT_FINISHED)
	hsm.add_transition(remote_attack_state, move_state, remote_attack_state.EVENT_FINISHED)
	
	hsm.initialize(self)
	hsm.set_active(true)
	
	remote_attack_state.set_guard(func(): return sp >= 1)
	
	hp = hp
	acc = raw_acc
	attack_speed = raw_attack_speed
	speed_x = raw_speed_x
	run_speed = raw_run_speed
	speed_y = raw_speed_y

func _physics_process(delta: float) -> void:
	sp += delta * raw_sp_rate
	sp = min(max_sp, sp)
	if is_zero_approx(target_velocity.y):
		velocity.y = velocity.y - 9.8 * delta
	else:
		velocity.y = target_velocity.y
		target_velocity.y = 0
	velocity.x = move_toward(velocity.x, target_velocity.x, acc)
	if target_velocity.x > 0:
		model.flip_h = false
		attack_area.rotation.y = 0
	elif target_velocity.x < 0:
		model.flip_h = true
		attack_area.rotation.y = PI
		
	move_and_slide()
	camera_position.position.x = clampf(velocity.x * 2, -3, 3)
	
func attacked(damage):
	hp -= damage
	need_camera_noise.emit()
