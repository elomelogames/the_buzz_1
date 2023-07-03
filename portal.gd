extends MeshInstance3D

@export var portal_exit: StaticBody3D

func _on_portal_area_body_entered(body):
	if body.name == "Player":
		var spawn_pos = Vector3(portal_exit.global_position.x-2, portal_exit.global_position.y, portal_exit.global_position.z)
		get_node("/root/Main").teleport(spawn_pos)

