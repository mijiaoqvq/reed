extends Enemy

const bullet_scene := preload("res://scenes/dmage_bullet.tscn")

func attack():
	var bullet : CharacterBody3D = bullet_scene.instantiate()
	var direction : Vector3 = (get_node(player_path).global_position - %Emit.global_position)

	add_child(bullet)
	bullet.velocity = direction.normalized() * 4
	bullet.global_position = %Emit.global_position
