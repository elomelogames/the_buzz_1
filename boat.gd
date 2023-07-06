extends RigidBody3D

@export var required_objects:Array
@export var player: CharacterBody3D


#func _on_boat_area_body_entered(body):
#	if body.name == "Player":
#		if player.carried_inventory.has("boat_key"):
#			player.remove_from_carried_inventory("boat_key")
#			required_objects.erase("BoatKey")
#			print("used key on boat")
#			check_required_objects()
			
func activate(state: bool):
	required_objects.erase("BoatKey")
	print("used key on boat")
	required_objects.erase("BoatKey")
	check_required_objects()
	
	
#	required_objects.erase("Plank")
#	print(required_objects)

func check_required_objects():
	if required_objects.size()==0:
		print ("Boat Ready")
#		$BoatCamera.current = true
		var main_cam:Camera3D = get_node("/root/Main/Camera3D")
		CameraTransition.transition_camera3D( main_cam,%BoatCamera, 3.0)
		var yield_timer_a = Timer.new()
		add_child(yield_timer_a)
		yield_timer_a.start(4);
		await yield_timer_a.timeout
		print ("MOVE NOW")
		move_boat()

func move_boat():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector3(-100, 0, 150), 30)



func saveObject() -> Dictionary:
	var dict := {
		"filepath": get_path(),
		"required_objects": required_objects,

		
	}
	return dict
	
func loadObject(loadedDict: Dictionary) -> void:
	required_objects = loadedDict.required_objects
	print ("remaining obkects "+str(required_objects))
