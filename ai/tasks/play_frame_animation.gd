@tool
extends BTAction

@export var sprite_path : NodePath

@export var animation : StringName

@export var speed_scale : float = 1.0

@export var from_end := false

# Display a customized name (requires @tool).
func _generate_name() -> String:
	return "Play Animation"

# Called each time this task is ticked (aka executed).
func _tick(_delta: float) -> Status:
	var sprite: AnimatedSprite3D = agent.get_node(sprite_path)
	if sprite.is_playing() and sprite.animation == animation:
		return RUNNING
	else:
		return SUCCESS

func _enter() -> void:
	var sprite: AnimatedSprite3D = agent.get_node(sprite_path)
	sprite.play(animation, speed_scale, from_end)
