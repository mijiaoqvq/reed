class_name Necrass
extends Enemy

signal dead

@export var reed : Node

func generate_constrained_value(a: float, b: float, c: float, d: float) -> float:
	
	var target_min = a - b
	var target_max = a + b
	
	var forbidden_min = c - d
	var forbidden_max = c + d
	
	if forbidden_max < target_min:
		return randf_range(target_min, target_max)
	
	if forbidden_min > target_max:
		return randf_range(target_min, target_max)
	
	var left_start = target_min
	var left_end = min(forbidden_min, target_max)
	var left_size = max(0.0, left_end - left_start)
	
	var right_start = max(forbidden_max, target_min)
	var right_end = target_max
	var right_size = max(0.0, right_end - right_start)

	
	var total_size = left_size + right_size
	
	if left_size > 0.0 and (right_size <= 0.0 or randf() < (left_size / total_size)):
		return randf_range(left_start, left_end)
	else:
		return randf_range(right_start, right_end)

func end():
	dead.emit()
	await get_tree().create_timer(1, false, true)
	queue_free()

func random_tp():
	var point := global_position
	point.x = generate_constrained_value(origin.x, 3, global_position.x, 0.5)
	global_position = point

const bullet_scene := preload("res://scenes/necrass_bullet.tscn")

func attack2():
	var bullet : CharacterBody3D = bullet_scene.instantiate()
	if reed != null:
		var direction : Vector3 = (reed.global_position - %Emit.global_position)

		add_child(bullet)
		bullet.velocity = direction.normalized() * 6
		bullet.global_position = %Emit.global_position
