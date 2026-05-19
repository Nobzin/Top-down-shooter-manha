extends CharacterBody2D

@export var jogador = CharacterBody2D
@onready var animacoes_inimigo = $inimigo_ataques_anim
@onready var ataque_collision = $ataque_area/colisao_ataque
var direction:= Vector2.ZERO
var SPEED = 900
var in_area = false
var atacando = false
func _physics_process(delta: float) -> void:
	mover()
	move_and_slide()
	
func mover():
	if jogador:
		direction = (jogador.global_position - global_position).normalized()
		velocity = direction * SPEED
		rotation = direction.angle()
		
func atacar():
	if atacando:
		return
	
	atacando = true
	

	animacoes_inimigo.play("ataque")
	await get_tree().create_timer(1).timeout
		

		
	atacando = false
func _on_ataque_area_body_entered(body: CharacterBody2D) -> void:
	if body == jogador:
		in_area = true
		atacar()
		
		

func _on_ataque_area_body_exited(body: CharacterBody2D) -> void:
	if body == jogador:
		in_area = false
		ataque_collision.disabled = true
