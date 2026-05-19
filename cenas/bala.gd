extends Area2D

var direction = Vector2.ZERO
var velocity: float = 10000
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	rotation = direction.angle()
	position += velocity * direction * delta
	
