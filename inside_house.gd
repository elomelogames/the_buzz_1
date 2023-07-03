extends Node3D

func _ready():
	$Player.rotation.y = 86
	var tween =  get_tree().create_tween()
	tween.tween_property($PanelContainer, "modulate:a", 
	0, 2)
	tween.play()
	
