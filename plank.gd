extends RigidBody3D

var carried:= false
var near_boat:=false
@export var my_drop_object: RigidBody3D

@export var in_tree:bool = false

func _ready():
	if in_tree:
		freeze = true

func carried_state(state:bool):
	carried = state
	if not carried and near_boat:
		print("added to boat "+name)
		my_drop_object.required_objects.erase(str(name))
		print (my_drop_object.required_objects)
		my_drop_object.check_required_objects()
		queue_free()
		


func _on_plank_area_area_entered(area):
	near_boat = true


func _on_plank_area_body_entered(body):
	print (body.name)
	if in_tree and body.name == "Stone":
		freeze = false
		in_tree = false
