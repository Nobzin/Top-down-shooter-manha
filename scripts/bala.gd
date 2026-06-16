extends Area2D

var direction = Vector2.ZERO
var velocity: float = 10000
var dano = 30
var dano_base = 30
var posicao_inicial:Vector2
func _ready() -> void:
	$AnimatedSprite2D.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	rotation = direction.angle()
	position += velocity * direction * delta
	


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Inimigos"):
		var distancia = posicao_inicial.distance_to(global_position)
		var dano_final = dano_base - distancia * 0.005
		dano_final = max(dano_final,dano_base *0.2)
		body.inimigo_tomar_dano(global_position,round(dano_final))
		queue_free()
