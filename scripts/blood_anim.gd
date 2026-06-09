extends AnimatedSprite2D
@onready var animacao = $damage_anim
@onready var damage_Anim = $Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animacao.play("damage_in")
	await animacao.animation_finished
	queue_free()
