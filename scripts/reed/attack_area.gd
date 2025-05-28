extends Area3D

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group(&"enemy"):
		print("hit enemy")
		body.attacked(1)
		$"../AnimationPlayer".play("camera_noise")
