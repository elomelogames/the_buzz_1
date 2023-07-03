extends Node3D

var can_flash: bool = false

var num1: int = 4
var num2: int = 5
var num3: int = 2

func _ready():
	pass
#	%CloseLightAnim.play("flash_code")
#	flash_code()

func activated(state):
	if state:
		can_flash = true
		flash_code()
	else:
		can_flash = false

func flash_code():
	for i in num1:
		%CloseLightAnim.play("one_flash")
		await %CloseLightAnim.animation_finished
	%CloseLightAnim.play("blank")
	await %CloseLightAnim.animation_finished
	for i in num2:
		%CloseLightAnim.play("one_flash")
		await %CloseLightAnim.animation_finished
	%CloseLightAnim.play("blank")
	await %CloseLightAnim.animation_finished
	for i in num3:
		%CloseLightAnim.play("one_flash")
		await %CloseLightAnim.animation_finished
	%CloseLightAnim.play("blank")
	await %CloseLightAnim.animation_finished
	if can_flash:
		flash_code()
