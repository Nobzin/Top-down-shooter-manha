extends Area2D

var direction = Vector2.ZERO
var velocity: float = 10000
var dano = 30
func _ready() -> void:
	$AnimatedSprite2D.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	rotation = direction.angle()
	position += velocity * direction * delta
	


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Inimigos"):
		body.inimigo_tomar_dano(global_position)
		self.queue_free()
		
