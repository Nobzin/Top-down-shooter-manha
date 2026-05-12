extends Node2D
var number = 0
var character = null
@onready var pos1 = $pos1
@onready var pos2 = $pos2
@onready var pos3 = $pos3


func select():

	if Input.is_action_just_pressed("direita"):
		number +=1
	elif Input.is_action_just_pressed("esquerda"):
		number -= 1
		
	if number >2 :
		number = 0
	elif number <0:
		number = 2
	if number == 0:
		$Seta.global_position = pos1.global_position
		character = "marston"
	elif number == 1:
		$Seta.global_position = pos2.global_position
		character = "morgan"
	elif number == 2:
		$Seta.global_position = pos3.global_position
		character = "van_der_linde"
	print(number)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	select()
