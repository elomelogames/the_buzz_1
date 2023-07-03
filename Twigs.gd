extends Node3D

@export var noise_trigger: Node3D

func _on_twigs_area_body_entered(body):
	if body.name == "Player":
		%TwigAudio.play()
		noise_trigger.part_open()
		
