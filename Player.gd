extends CharacterBody3D

var camera: Camera3D
var head: Node3D

var walk_speed: float = 5.0
var run_speed: float = 10.0

var move_speed: float = 5.0
var jump_force: float = 5.0
var gravity: float = 9.0

var can_play_walking: bool = true
var can_play_stopping: bool = true


var look_sens: float = 0.5
var min_x_rotation: float = -85.0
var max_x_rotation: float = 85.0
var mouse_dir: Vector2

var using_mouse: bool = false

var object_touching: Node3D
var carried_item: Node3D
var hand: Node3D

var carrying_object: bool = false

var raycast : RayCast3D
var my_hand: Marker3D
var picked_object
var pull_strength: float = 8

var can_drop :bool = false

var carried_inventory:Array = []

@export var hud:Control

@export var buzz: CharacterBody3D

var step_player: AudioStreamPlayer

#var foot_tween_on: Tween
#var foot_tween_off: Tween



var walk_audio = preload("res://assets/audio/footsteps_normal.mp3")
var run_audio = preload ("res://assets/audio/run_f.mp3")

func _ready():
	
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN

	walk_audio.loop=true
	run_audio.loop = true
	camera = get_node("Camera3D")
	head = get_node("Head")
	remove_child(camera)
	get_node("/root/Main").add_child.call_deferred(camera)

	

func add_to_carried_inventory(item:String):
	carried_inventory.append(item)
	hud.add_to_carried_inventory(item)	

func remove_from_carried_inventory(item:String):
	if carried_inventory.has(item):
		carried_inventory.erase(item)
		hud.remove_from_carried_inventory(item)

func pick_object():
	if raycast == null:
		return	
	var collider = raycast.get_collider()
	if collider == null:
		hud.spot_intensity(false)
	if collider != null and collider is RigidBody3D:
		if collider.name == "Boat":
			_check_boat_key(collider)
			return
		picked_object = collider
		print ("picked "+collider.name)
		picked_object.carried_state(true)
		hud.spot_intensity(true)
		can_drop = false
		%ThrowTimer.start()
	if collider != null and collider is StaticBody3D:
		_clicked_static(collider)
		hud.spot_intensity(true)
		can_drop = false
		%ThrowTimer.start()
#	if collider != null and collider is Node3D:
#		_clicked_node(collider)

func drop_object():
	if not can_drop:
		return
	if picked_object != null:
		if picked_object.name == "Stone":
			print ("Throw Stone")
			var knockback = picked_object.position - position
			picked_object.throw_me(knockback*3)
		picked_object.carried_state(false)
		picked_object = null

func _input(event):
	if event is InputEventMouseMotion and not using_mouse:
		camera.rotation_degrees.x += event.relative.y * -look_sens
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, min_x_rotation, max_x_rotation )
		camera.rotation_degrees.y += event.relative.x * -look_sens
	
	if Input.is_action_just_pressed("run"):
		can_play_walking = true
		move_speed = run_speed

	if Input.is_action_just_released("run"):
		can_play_walking = true
		move_speed = walk_speed	
	


	
	if Input.is_action_just_pressed("pick_object") and not using_mouse:
		if picked_object == null:
			pick_object()
		else:
			drop_object()
#		hand = get_node("/root/Main/Camera3D/Hand")
#		if object_touching != null and event.button_index==1:
##			object_touching.freeze_me(true)
##			object_touching.reparent(hand)
##			object_touching.holding(3)
#			carried_item = object_touching
#			carrying_object = true
#			print ("GRABBED")
#			carrying_object = true
#			hand.get_child(0).holding(true)
#			hand.get_child(0).global_transform.origin = hand.global_transform.origin
#			hand.get_child(0).position = Vector3.ZERO
#			hand.get_child(0).position.y = 1
#			hand.get_child(0).rotation_degrees = Vector3.ZERO
#			print (hand.rotation_degrees)
#			print (hand.get_child(0).rotation_degrees)
#			hand.get_child(0).body_rotation()

			
#		if hand.get_child_count() > 0 and event.button_index==2:
##			object_touching.holding(0)
#			carrying_object = false
#			carried_item = null
##			hand.get_child(0).freeze_me(false)
##			hand.get_child(0).reparent(get_node("/root/Main"))
#			print ("DROPPED")



	

func check_if_facing(target, threshold):
#	print (global_position.angle_to(target) - threshold, global_position.angle_to(target) + threshold)
	var rot = wrapf(camera.rotation_degrees.y, 0, 360)
#	var dir = to_local(buzz.global_transform.origin)
	var dir = rad_to_deg(global_position.angle_to(buzz.global_position))
#	print ("enemy dir "+str(dir))
	var behind = global_position.x>buzz.global_position.x
#	print ("behind "+str(behind))
	var final_dir = rot+dir
	if !behind:
		final_dir = wrapf(final_dir+180, 0,360)
#	print ("final dir "+str(final_dir))
	if final_dir >60 and final_dir < 100:
		hud.buzz_display("t")
	elif final_dir > 0 and final_dir <69:
		hud.buzz_display("tl")
	elif final_dir > 101 and final_dir <160:
		hud.buzz_display("tr")
	elif final_dir > 160 and final_dir <180:
		hud.buzz_display("r")
	elif final_dir > 180 and final_dir <240:
		hud.buzz_display("br")
	elif final_dir > 240 and final_dir <280:
		hud.buzz_display("b")
	elif final_dir > 280 and final_dir <340:
		hud.buzz_display("bl")
	elif final_dir > 340 and final_dir <360:
		hud.buzz_display("l")
#	elif final_dir > 0 and final_dir <360:
#		hud.buzz_display("l")
	else:
		hud.buzz_display("none")
		
#	print ("tot "+str(final_dir))
	
		
	
func _process(delta):

	camera.position = head.global_position
	if raycast == null:
		hud.spot_intensity(false)
		return
	var collider = raycast.get_collider()
	if collider == null:
		hud.spot_intensity(false)
	if collider != null and collider is RigidBody3D:
		hud.spot_intensity(true)
	if collider != null and collider is StaticBody3D:
		hud.spot_intensity(true)

	if buzz != null:
		check_if_facing(buzz.position, 60)


	

	if Input.is_action_just_pressed("escape"):
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
			using_mouse = false
		else:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			using_mouse = true

func _set_walk_off():
	can_play_stopping = true

func _set_walk_on():
	can_play_walking = true

func _physics_process(delta):
	
	
	if carrying_object:
		carried_item.global_transform.origin = hand.global_transform.origin
	
#	if using_mouse:
#		return
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force
		
	
	var input = Input.get_vector("move_left","move_right","move_forward","move_back")
	
	var dir = camera.basis.z * input.y + camera.basis.x * input.x
	dir.y = 0 
	dir = dir.normalized()
	velocity.x = dir.x * move_speed
	velocity.z = dir.z * move_speed
	
#	print (str(velocity.z)+"  x "+str(%footsteps.volume_db))
	
	
	if velocity.z  < -0.5 or velocity.z > 0.5:
		
		if can_play_walking:
			can_play_walking = false
			can_play_stopping = true
#			print ("should play walk")
			if move_speed == walk_speed:
				%footsteps.play()
				%runsteps.stop()
				var foot_tween_on = get_tree().create_tween()
				foot_tween_on.tween_property(%footsteps, "volume_db", -10, 1)
			else:
				%footsteps.stop()
				%runsteps.play()
				var run_tween_on = get_tree().create_tween()
				run_tween_on.tween_property(%runsteps, "volume_db", -10, 1)
#			print ("foot sound")
	else:
		if can_play_stopping:
#			print ("should stop walk")
			can_play_stopping = false
			can_play_walking = true
#			if move_speed == walk_speed:
			var foot_tween_off = get_tree().create_tween()
			foot_tween_off.tween_property(%footsteps, "volume_db", -80, 1)
			
			var run_tween_off = get_tree().create_tween()
			run_tween_off.tween_property(%runsteps, "volume_db", -80, 1)
							

	#		print ("foot out")


	
	if not using_mouse:
		move_and_slide()
	
	
	if picked_object != null:
		var a = picked_object.global_transform.origin
		var b = my_hand.global_transform.origin
		picked_object.set_linear_velocity((b-a)*pull_strength)


func _check_boat_key(item):
	if carried_inventory.has("boat_key"):
		remove_from_carried_inventory("boat_key")
		item.activate(true)
	else:
		print ("I need to find a key to unlock it.")

func _clicked_static(item):
	print (item.name)
	if item.name == "PadlockItem":
		print ("show pad")
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		using_mouse = true
		get_node("/root/Main").show_padlock()
	if item.name == "DoorCol":
		get_node("/root/Main/House").change_door()
	if item.name == "BoatKey":
		item.queue_free()
		add_to_carried_inventory("boat_key")
	if item.name == "Fuse":
		item.queue_free()
		add_to_carried_inventory("fuse")
	if item.name == "FuseBox":
		if carried_inventory.has("fuse"):
			remove_from_carried_inventory("fuse")
			item.activate(true)
		else:
			print ("It needs a fuse")
		
		
func _clicked_node(item):
	if item.name == "House":
		print ("at house")

func hide_mouse():
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	using_mouse = false


func _on_timer_timeout():
	raycast = get_node("/root/Main/Camera3D/RayCast3D")
	my_hand = get_node("/root/Main/Camera3D/MyHand")


func _on_throw_timer_timeout():
	can_drop = true
