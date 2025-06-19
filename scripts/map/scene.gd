class_name Scene
extends Node3D

@export var start_point: NodePath

@export var end_point: NodePath

var reed_copy: PackedScene = PackedScene.new()

@onready var reed:Node = %Reed

func _ready() -> void:
	reed_copy.pack(reed)
	reed.need_camera_noise.connect(_on_reed_need_camera_noise)
	reed.status_change.connect($UILayer._on_reed_status_change)
	reed.die.connect($UILayer.fail)
	%PhantomCamera3D.follow_target = reed.camera_position
	%UILayer.get_node("UI/Failed/VBoxContainer/Button").pressed.connect(back_to_checkpoint)
	for item in get_children():
		if item.is_in_group("checkpoint"):
			item.body_entered.connect(_on_checkpoint_entered)
	get_node(end_point).body_entered.connect(_on_scene_finished)
	_start()
	
	await get_tree().process_frame
	%GridMap.make_baked_meshes(true)

func _on_scene_finished(body:Node):
	if body.is_in_group(&"player"):
		_end()

func _start():
	pass
	
func _end():
	pass

func back_to_checkpoint():
	reed = reed_copy.instantiate()
	reed.need_camera_noise.connect(_on_reed_need_camera_noise)
	reed.status_change.connect($UILayer._on_reed_status_change)
	reed.die.connect($UILayer.fail)
	add_child(reed)
	%PhantomCamera3D.follow_target = reed.camera_position

func _on_checkpoint_entered(node: Node):
	if node.is_in_group("player"):
		checkpoint()

func checkpoint():
	reed_copy.pack(reed)

func _on_reed_need_camera_noise() -> void:
	%AnimationPlayer.play("camera_noise")
