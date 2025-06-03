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

@export var acc:= 0.2
@export var attack_speed:= 2.0
@export var speed_x := 1.0
@export var run_speed := 2.5
@export var speed_y := 3.0


signal status_change(Node)

var target_velocity : Vector3

var max_hp := 5
var hp := 5:
	set(value):
		hp = value
		status_change.emit(self)
		if hp <= 0:
			print("die")

func _ready() -> void:
	GUIDE.enable_mapping_context(preload("res://control/mapping_context.tres"))
	
	hsm.add_transition(idle_state, move_state, idle_state.EVENT_FINISHED)
	hsm.add_transition(move_state, idle_state, move_state.EVENT_FINISHED)
	hsm.add_transition(move_state, jump_state, "jump")
	hsm.add_transition(jump_state, move_state, jump_state.EVENT_FINISHED)
	hsm.add_transition(idle_state, attack_state, "attack")
	hsm.add_transition(move_state, attack_state, "attack")
	hsm.add_transition(jump_state, attack_state, "attack")
	hsm.add_transition(jump_state, jump_wall_state, "jump")
	hsm.add_transition(jump_wall_state, jump_state, jump_wall_state.EVENT_FINISHED)
	hsm.add_transition(attack_state, move_state, attack_state.EVENT_FINISHED)
	
	hsm.initialize(self)
	hsm.set_active(true)

			

func _physics_process(delta: float) -> void:
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
	$AnimationPlayer.play("camera_noise")
