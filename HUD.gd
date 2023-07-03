extends Control

var last_buzz_dir:TextureRect

var buzz_distance:float

	

func update_distance(dist:float):
	buzz_distance = dist
	
#	%Distance.text = "The BUZZ "+str(dist)
	%DistanceBar.size.x = 300/dist
	%DistanceBar.color = Color( 1/dist,1-(1/dist),1-(1/dist),1)
	

func spot_intensity(state: bool):
	if state:
		%Spot.modulate.a=1
	else:
		%Spot.modulate.a=0.5

func add_to_carried_inventory(item:String):
	match item:
		"boat_key":
			var key_icon = preload("res://inventory/key_icon.tscn").instantiate()
			key_icon.name = item
			%Inventory.add_child(key_icon)
			print ("inv item is "+key_icon.name)
		"fuse":
			var fuse_icon = preload("res://inventory/fuse_icon.tscn").instantiate()
			fuse_icon.name = item
			%Inventory.add_child(fuse_icon)
			print ("inv item is "+fuse_icon.name)

func remove_from_carried_inventory(item: String):
	var items = %Inventory.get_children()
	for icon in items:
		if icon.name == item:
			icon.queue_free()

		
func buzz_display(direction:String):
#	print ("hud dir "+direction)
	var new_buzz: TextureRect
	match direction:
		"tl":
			new_buzz = $TopLeft
		"t":
			new_buzz =$Top
		"tr":
			new_buzz =$TopRight
		"r":
			new_buzz =$Right
		"br":
			new_buzz =$BottomRight
		"b":
			new_buzz =$Bottom
		"bl":
			new_buzz =$BottomLeft
		"l":
			new_buzz =$Left
		"none":
			new_buzz = null

	if last_buzz_dir != null:
		var last_buzz_tween = get_tree().create_tween()
		last_buzz_tween.tween_property(last_buzz_dir, "modulate:a", 0, 2)
	if new_buzz != null:
		var buzz_tween = get_tree().create_tween()
		buzz_tween.tween_property(new_buzz, "modulate:a", 1, 2)
#		buzz_tween.play()
		last_buzz_dir = new_buzz
