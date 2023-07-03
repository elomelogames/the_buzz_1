extends Path3D

@export var speed: float = 4

var running: bool = false

func _physics_process(delta):
	if running:
		%Path1Follow.progress += speed * delta
