extends Path3D

@export var speed: float = 16

var running: bool = false

func _physics_process(delta):
	if running:
		%Nav2PathFollow.progress += speed * delta
