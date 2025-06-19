extends CharacterBody3D

@export var speed := 5.0

func _physics_process(delta: float) -> void:
	velocity.x = speed
	if move_and_slide():
		queue_free()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group(&"enemy"):
		body.attacked(2)
		await get_tree().create_timer(0.1, false, true).timeout
		queue_free()
