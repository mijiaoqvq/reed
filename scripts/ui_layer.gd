extends CanvasLayer

@onready var hp = %HP
@onready var sp = %SP

var esc := preload("res://control/esc.tres")

func _ready() -> void:
	esc.triggered.connect(_on_esc_triggered)

var pause = false

func _on_esc_triggered():
	if pause:
		Global.pause_count -= 1
		%Pause.visible = false
	else:
		Global.pause_count += 1
		%Pause.visible = true
	pause = not pause
	


func _on_reed_status_change(node: Variant) -> void:
	if not is_node_ready():
		await ready
	hp.max_value = node.max_hp
	hp.value = node.hp
	sp.max_value = node.max_sp
	sp.value = node.sp

func fail():
	%AnimationPlayer.play("show_failed")
	await %AnimationPlayer.animation_finished

var scene : AsyncScene

func _on_button_2_pressed() -> void:
	scene = AsyncScene.new("res://scenes/main.tscn", AsyncScene.LoadingSceneOperation.ReplaceImmediate)


func _on_button_pressed() -> void:
	%Failed.visible = false
