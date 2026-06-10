extends CharacterBody2D

@export var jogador = CharacterBody2D
@onready var animacoes_inimigo = $inimigo_ataques_anim
@onready var ataque_collision = $ataque_area/colisao_ataque
@onready var enemy_sound = $zombiedeath
@onready var death_anim = $death_anim
@onready var damage_anim = preload("res://cenas/blood_anim.tscn")
@onready var barra_vida = $ProgressBar
var direction:= Vector2.ZERO
var dano = 10
var dano_tomado = 0
var vida = randi_range(200,1000)
var SPEED = 900
var in_area = false
var atacando = false
var morto = false
func _ready() -> void:
	barra_vida.max_value = vida
func _physics_process(delta: float) -> void:
	barra_vida.value = vida
	if not morto:
		mover()
	move_and_slide()

func mover():
	if jogador:
		direction = (jogador.global_position - global_position).normalized()
		velocity = direction * SPEED * Global.Game_speed
		rotation = direction.angle()
		
func atacar():
	if atacando and not morto:
		return
	
	atacando = true
	

	animacoes_inimigo.play("ataque")
	await get_tree().create_timer(0.6).timeout
	if jogador and self.morto == false:
		jogador.tomar_dano(dano)
	else:
		in_area = false
	
	atacando = false
	if in_area:
		await get_tree().create_timer(0.4).timeout
		atacar()
func _on_ataque_area_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("Player"):
		in_area = true
		atacar()
		
		

func _on_ataque_area_body_exited(body: CharacterBody2D) -> void:
	if body.is_in_group("Player"):
		in_area = false
		ataque_collision.disabled = true

func inimigo_tomar_dano(position , dano):
	dano_tomado = dano
	vida -= dano_tomado
	var sangue = damage_anim.instantiate()
	get_parent().add_child(sangue)
	sangue.damage_Anim.text = str(dano_tomado)
	sangue.global_position = position
	sangue.play(str(randi_range(1,5)))
	if vida <=0:
		morto = true
		velocity = Vector2.ZERO
		enemy_sound.play()
		death_anim.play("death1")
		await death_anim.animation_finished
		Global.kills +=1
		self.queue_free()
		
