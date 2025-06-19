@tool
extends BTAction

@export var area : float = 5
# Display a customized name (requires @tool).

var path_found = false

var finished = false

func _generate_name() -> String:
	return "Random move"
	

# Called each time this task is ticked (aka executed).
func _tick(_delta: float) -> Status:
	if not path_found:
		return FAILURE
	if not finished and not agent.is_on_wall() and abs(agent.velocity.length()) > 0.01:
		return RUNNING
		
	return SUCCESS

func _enter() -> void:
	var navigation_agent : NavigationAgent3D = agent.navigation_agent
	if not navigation_agent.navigation_finished.is_connected(_on_navigation_finished):
		navigation_agent.navigation_finished.connect(_on_navigation_finished)
	finished = false
	for i in range(10):
		agent.set_movement_target(agent.origin + Vector3(randf_range(-area,area),0,0))
		if navigation_agent.is_target_reachable():
			path_found = true
			break

func _on_navigation_finished():
	finished = true
