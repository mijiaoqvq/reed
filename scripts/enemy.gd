class_name Enemy
extends CharacterBody3D

@export var hp := 3
@export var damage := 1
@export var movement_speed: float = 2.0

@onready var navigation_agent: NavigationAgent3D = get_node("NavigationAgent3D")

var origin : Vector3

func _ready() -> void:
	$Info.max_hp = hp
	$Info.hp = hp
	origin = global_position
	navigation_agent.velocity_computed.connect(Callable(_on_velocity_computed))

func attacked(damage2):
	hp -= damage2
	$Info.hp = hp
	if hp > 0:
		$AnimationPlayer.play("blink")
	else:
		$BTPlayer.restart()

func _physics_process(delta: float) -> void:
	velocity.y = velocity.y - 9.8 * delta
	if player_path == NodePath():
		if velocity.x > 0:
			$AnimatedSprite3D.flip_h = false
		elif velocity.x < 0:
			$AnimatedSprite3D.flip_h = true
	else:
		$AnimatedSprite3D.flip_h = get_node(player_path).global_position.x - global_position.x < 0
	move_and_slide()
	
	# Do not query when the map has never synchronized and is empty.
	if NavigationServer3D.map_get_iteration_id(navigation_agent.get_navigation_map()) == 0:
		return
	if navigation_agent.is_navigation_finished():
		return

	var next_path_position: Vector3 = navigation_agent.get_next_path_position()
	var new_velocity: Vector3 = global_position.direction_to(next_path_position) * movement_speed
	if navigation_agent.avoidance_enabled:
		navigation_agent.set_velocity(new_velocity)
	else:
		_on_velocity_computed(new_velocity)

func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)

func get_target_position():
	pass

@export var player_path: NodePath

func _on_attack_area_body_entered(body: Node3D) -> void:
	if body.is_in_group(&"player"):
		player_path = get_path_to(body)
		$BTPlayer.restart()
		

func _on_attack_area_body_exited(body: Node3D) -> void:
	if body.is_in_group(&"player"):
		player_path = NodePath()

func attack():
	get_node(player_path).attacked(damage)
	
func _on_velocity_computed(safe_velocity: Vector3):
	velocity.x = safe_velocity.x
	
func stop_navgation():
	set_movement_target(global_position)
	velocity.x = 0
