extends StaticBody3D

var activated: bool = false

@export var activate_item: Node3D

func activate(state: bool):
	activated = state
	activate_item.activated(activated)


func saveObject() -> Dictionary:
	var dict := {
		"filepath": get_path(),
		"activated": activated		
	}
	return dict
	
func loadObject(loadedDict: Dictionary) -> void:
	activated = loadedDict.activated
	activate(activated)
