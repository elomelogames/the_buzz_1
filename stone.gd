extends RigidBody3D

var carried:= false



func carried_state(state:bool):
	carried = state
	if carried:
		lock_rotation = true
	else:
		lock_rotation = false
		

		
		
func throw_me(impulse: Vector3):
	lock_rotation = false
	apply_central_impulse(impulse)


func saveObject() -> Dictionary:
	var dict := {
		"filepath": get_path(),
		"posX": global_position.x,
		"posY": global_position.y,
		"posZ": global_position.z,		
	}
	return dict
	
func loadObject(loadedDict: Dictionary) -> void:
	global_position.x = loadedDict.posX
	global_position.y = loadedDict.posY
	global_position.z = loadedDict.posZ
