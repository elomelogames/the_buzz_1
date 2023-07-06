extends StaticBody3D

var was_picked_up :bool = false

func picked_up(state: bool):
	was_picked_up = state
	visible = !was_picked_up
	%FuseCol.disabled = !was_picked_up


func saveObject() -> Dictionary:
	var dict := {
		"filepath": get_path(),
		"was_picked_up": was_picked_up,
		"xPos": global_position.x,
		"yPos": global_position.y,
		"zPos": global_position.z,
	
	}
	return dict
	
func loadObject(loadedDict: Dictionary) -> void:
	was_picked_up = loadedDict.was_picked_up
	global_position.x = loadedDict.xPos
	global_position.y = loadedDict.yPos
	global_position.z = loadedDict.zPos
	picked_up(was_picked_up)
