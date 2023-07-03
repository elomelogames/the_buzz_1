extends Node3D

var unlocked = false


func _on_area_3d_body_entered(body):
	if not unlocked:
		return
	if body.name == "Player":
		$AnimationPlayer.play("door_open")





func _on_area_3d_body_exited(body):
	if not unlocked:
		return
	if body.name == "Player":
		$AnimationPlayer.play("door_close")
