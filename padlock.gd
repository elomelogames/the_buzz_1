extends Control

var numbers: Array = [0,0,0]

var combination: Array = [4,5,2]

var lock_state: bool = false

var is_active: bool = false

@export var linked_item: Node3D

#func _unhandled_input(event):
#	if not visible:
#		return
#	if Input.is_action_just_pressed("pick_object"):
#		if visible:
#			visible = false

	

func _on_one_up_pressed():
	if lock_state:
		return
	numbers[0] += 1
	if numbers[0] > 9:
		numbers[0] = 0
	%No1.text = str(numbers[0])
	check_combination()


func _on_two_up_pressed():
	if lock_state:
		return
	numbers[1] += 1
	if numbers[1] > 9:
		numbers[1] = 0
	%No2.text = str(numbers[1])
	check_combination()


func _on_three_up_pressed():
	if lock_state:
		return
	numbers[2] += 1
	if numbers[2] > 9:
		numbers[2] = 0
	%No3.text = str(numbers[2])
	check_combination()



func _on_one_down_pressed():
	if lock_state:
		return
	numbers[0] -= 1
	if numbers[0] < 0:
		numbers[0] = 9
	%No1.text = str(numbers[0])
	check_combination()


func _on_two_down_pressed():
	if lock_state:
		return
	numbers[1] -= 1
	if numbers[1] < 0:
		numbers[1] = 9
	%No2.text = str(numbers[1])
	check_combination()


func _on_three_down_pressed():
	if lock_state:
		return
	numbers[2] -= 1
	if numbers[2] < 0:
		numbers[2] = 9
	%No3.text = str(numbers[2])
	check_combination()

func check_combination():
	if numbers == combination:
		print ("OPEN")
		lock_state = true
		linked_item.unlocked = true
		visible = false
		is_active = false
		get_node("/root/Main").hide_padlock()
		


#func _on_lock_click_off_pressed():
#	if not visible:
#		print ("hide padlock")
#		return
#
#	if visible and is_active:
#		visible = false
#		get_node("/root/Main").hide_padlock()
#		is_active = false


#func _on_lock_click_off_button_up():
#	if not visible:
#		print ("hide padlock")
#		return
#
#	if visible and is_active:
#		visible = false
#		get_node("/root/Main").hide_padlock()
#		is_active = false


func _on_lock_click_off_button_down():
	if not is_active:
		print ("hide padlock")
		return
	
	if visible and is_active:
		visible = false
		is_active = false
		get_node("/root/Main").hide_padlock()
		

func activate():
	if lock_state:
		return
	visible = true
	%Timer.start()

func _on_timer_timeout():
	print ("PL timeout")
	is_active = true
