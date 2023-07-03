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


