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
		visible = false
		%PlankColl.disabled = true
		


func _on_plank_area_area_entered(area):
	near_boat = true


func _on_plank_area_body_entered(body):
	print (body.name)
	if in_tree and body.name == "Stone":
		freeze = false
		in_tree = false


func saveObject() -> Dictionary:
	var dict := {
		"filepath": get_path(),
		"xPos": global_position.x,
		"yPos": global_position.y,
		"zPos": global_position.z,
		"in_tree": in_tree,
		"freeze": freeze,
		"visible": visible,
		"disabled":%PlankColl.disabled
		
	}
	return dict
	
func loadObject(loadedDict: Dictionary) -> void:
	in_tree = loadedDict.in_tree
	freeze = loadedDict.freeze
	visible = loadedDict.visible
	%PlankColl.disabled = loadedDict.disabled
	global_position.x = loadedDict.xPos
	global_position.y = loadedDict.yPos
	global_position.z = loadedDict.zPos

