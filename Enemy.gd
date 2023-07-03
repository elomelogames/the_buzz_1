extends CharacterBody3D

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@export var hud: Control

var modes: Array = ["follow", "patrol"]

var current_mode:int = 0

var speed: float = 2.0

var my_target: Vector3

func switch_mode(mode_selected:int, path: PathFollow3D):
	current_mode = mode_selected
	if modes[current_mode] == "follow":
		reparent(get_node("/root/Main"))
	elif modes[current_mode] == "patrol":
		reparent(path, false)
		position = Vector3.ZERO
		path.get_parent().running = true

func update_target_location(target_location):
	nav_agent.set_target_position(target_location)
	my_target = target_location
	

func _physics_process(delta):
	if modes[current_mode] == "follow":
		var current_location = global_transform.origin
		var next_location = nav_agent.get_next_path_position()
#		print(next_location)
		nav_agent.set_velocity((next_location - current_location).normalized() * speed)
#		var new_velocity = (next_location - current_location).normalized() * speed
		var send_distance:float = snapped(current_location.distance_to(my_target),0.1)
		hud.update_distance(send_distance)
		look_at(my_target)




func _on_switch_timer_timeout():
	pass
#	switch_mode(1, get_node("/root/Main/Path1/Path1Follow"))


func _on_navigation_agent_3d_velocity_computed(safe_velocity):
	
	velocity = safe_velocity
#	print ("safe move "+str(velocity))		
	move_and_slide()
