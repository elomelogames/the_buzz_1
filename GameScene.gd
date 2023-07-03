extends Node3D

@onready var player = %Player

func _physics_process(delta):
	get_tree().call_group("enemies","update_target_location",player.global_transform.origin)
	

func teleport():
	player.position = Vector3(48.8, 12.1, -290)

func show_padlock():
	%Padlock.activate()

func hide_padlock():
	player.hide_mouse()
