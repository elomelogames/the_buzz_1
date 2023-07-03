extends Node3D

@onready var player = %Player

func _physics_process(delta):
	get_tree().call_group("enemies","update_target_location",player.global_transform.origin)
	

func teleport(exit_pos):
	player.global_position = exit_pos

func show_padlock():
	%Padlock.activate()

func hide_padlock():
	player.hide_mouse()
