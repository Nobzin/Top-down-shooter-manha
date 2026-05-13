extends CharacterBody2D

const SPEED = 1200
const JUMP_VELOCITY = -400.0
var direcao = Vector2.ZERO
@onready var ponta_arma = $ponta_da_arma
@export var bala_cena: PackedScene
@onready var cooldown = $cooldown
var cooldowns = false
func _physics_process(delta: float) -> void:
	mover()
	rotacao()
	

	move_and_slide()

func mover():
	direcao = Input.get_vector("esquerda","direita","cima","baixo")
	
	velocity = direcao * SPEED
	
func rotacao():
	look_at(get_global_mouse_position())
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("atirar") and cooldowns == false:
		
		disparar()


func disparar():
	cooldowns = true
	cooldown.start(1)
	if cooldowns == true:
		
		var nova_bala = bala_cena.instantiate()
		nova_bala.global_position = ponta_arma.global_position
		nova_bala.direction = (ponta_arma.global_position - global_position).normalized()
		get_tree().current_scene.add_child(nova_bala)
		$AudioStreamPlayer2D.play()
	

		
	
	await cooldown.timeout
	cooldowns = false
	
	
