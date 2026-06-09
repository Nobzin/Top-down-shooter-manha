extends CharacterBody2D

const SPEED = 1200
const JUMP_VELOCITY = -400.0
var vida = 100
var dano_tomado = 0
var dano = 30
@onready var status_player = $status
@onready var status_pos = $Marker2D
var direcao = Vector2.ZERO
var dead_eye_timer = 0.0
@onready var deadeye_effect = $CanvasLayer/dead_eyeeffect
@onready var anim_dead_eye = $CanvasLayer/dead_eye_anim
@onready var ponta_arma = $ponta_da_arma
@export var bala_cena: PackedScene
@onready var cooldown = $cooldown
@onready var sound_effects = $AudioStreamPlayer2D
@onready var arma_animation = $Animacoes_arma
@export var shoot_particles: PackedScene
@onready var dead_eye_cooldown = $dead_eye_cooldown
@onready var Player_gui = $Player_gui
var cooldowns = false
var dead_eye = false
func _physics_process(delta: float) -> void:
	mover()
	rotacao()

	move_and_slide()

func mover():
	direcao = Input.get_vector("esquerda","direita","cima","baixo")
	
	velocity = direcao * SPEED * Global.Game_speed
	if Global.Game_speed != 1:
		velocity = direcao * SPEED * (Global.Game_speed * 2)
func rotacao():
	look_at(get_global_mouse_position())
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("atirar") and cooldowns == false:
		if dead_eye:
			dead_eye = false
			_dead_eye()
		disparar()
	elif event.is_action_pressed("Dead_eye"):
		dead_eye = true
		_dead_eye()
	
func disparar():
	cooldowns = true
	cooldown.start(0.01)
	
	var nova_particula = shoot_particles.instantiate()
	nova_particula.position = ponta_arma.position
	add_child(nova_particula)
	var nova_bala = bala_cena.instantiate()
	nova_bala.global_position = ponta_arma.global_position
	nova_bala.direction = (ponta_arma.global_position - global_position).normalized()
	nova_bala.dano = dano
	if dead_eye:
		nova_bala.dano *= 100
	get_tree().current_scene.add_child(nova_bala)
	sound_effects.play()
	await get_tree().create_timer(0.63).timeout
	sound_effects.stop()
	await cooldown.timeout
	sound_effects.play(0.52)
	arma_animation.play("Recharge")
	await arma_animation.animation_finished
	cooldowns = false	
func tomar_dano(inimigo_dano):
	dano_tomado = inimigo_dano
	vida -= dano_tomado
	print(vida)
	if vida <=0:
		self.queue_free()
		
func _dead_eye():
	if dead_eye:
		dead_eye_cooldown.start(5)
		Global.Game_speed = 0.2
		deadeye_effect.visible = true
		anim_dead_eye.play("dead_eye")
		await dead_eye_cooldown.timeout
		dead_eye = false
		_dead_eye()
	else:
		Global.Game_speed = 1
		deadeye_effect.visible = false
