extends Node3D

var door_open:= false

func change_door():
	if door_open:
		%DoorAnimation.play("door_close")
		door_open = false
	else:
		%DoorAnimation.play("door_open")
		door_open = true
		%SpotLight3D.visible = true


func _on_door_animation_animation_finished(anim_name):
	if not door_open:
		%SpotLight3D.visible = false


func _on_enter_house_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file("res://inside_house.tscn")
