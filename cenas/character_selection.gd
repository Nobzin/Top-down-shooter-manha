extends Node2D
var number = 0
var character = null
@onready var pos1 = $pos1
@onready var pos2 = $pos2
@onready var pos3 = $pos3
func _ready() -> void:
	update_selection()
func _input(event: InputEvent) -> void:

	if event.is_action_pressed("direita"):
		number +=1
		update_selection()
	elif event.is_action_pressed("esquerda"):
		number -= 1
		update_selection()
func update_selection():
	if number >2 :
		number = 0
	elif number <0:
		number = 2
	$animacoes_arma.stop()
	$animacoes_personagens.stop()
	if number == 0:
		$Seta.global_position = pos1.global_position
		character = "marston"
		$animacoes_arma.play("marston_gun")
		$animacoes_personagens.play("marston_arma")
	elif number == 1:
		$Seta.global_position = pos2.global_position
		character = "morgan"
		$animacoes_arma.play("morgan_gun")
		$animacoes_personagens.play("morgan_selected")
	elif number == 2:
		$Seta.global_position = pos3.global_position
		character = "van_der_linde"
	print(number)
