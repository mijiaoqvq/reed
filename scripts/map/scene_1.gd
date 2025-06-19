extends Scene

@export var skip_log : bool = false

func _start():
	if not skip_log:
		%Balloon.start(preload("uid://b1n04ha23m7jd"))
		await %Balloon.finished
		charpter1()

var scene : AsyncScene
func _end():
	if scene == null:
		scene = AsyncScene.new("res://scenes/scene_2.tscn", AsyncScene.LoadingSceneOperation.ReplaceImmediate)
	
func charpter1():
	%Balloon.start(preload("uid://31lu0uqi4scb"))
	await %Balloon.finished
	%Balloon.fade()
	var game_states:Array = Engine.get_singleton("DialogueManager").game_states
	if game_states.has("end"):
		await get_tree().physics_frame
		await get_tree().physics_frame
		reed.hp = 0
		
		
func back_to_checkpoint():
	super.back_to_checkpoint()
	var game_states:Array = Engine.get_singleton("DialogueManager").game_states
	if game_states.has("end"):
		game_states.erase("end")
		charpter1()
