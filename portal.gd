extends MeshInstance3D


func _on_portal_area_body_entered(body):
	if body.name == "Player":
		get_node("/root/Main").teleport()
