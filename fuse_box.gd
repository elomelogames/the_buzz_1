extends StaticBody3D

var activated: bool = false

@export var activate_item: Node3D

func activate(state: bool):
	activate_item.activated(state)
