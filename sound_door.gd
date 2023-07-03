extends Node3D

func part_open():
	if %SoundDoorAnim.current_animation != "full_open":
		%SoundDoorAnim.play("part_open")

func full_open():
	%SoundDoorAnim.play("full_open")


func close():
	%SoundDoorAnim.play("close")


func _on_sound_door_area_body_entered(body):
	if body.name == "Enemy":
		print ("enemy enter open")
		full_open()



func _on_sound_door_area_body_exited(body):
	if body.name == "Enemy":
		print ("enemy enter close")
		close()
