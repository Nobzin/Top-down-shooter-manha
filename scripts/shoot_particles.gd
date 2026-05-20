extends Node2D

@onready var particles = $Particles
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	particles.play("default")
	await particles.animation_finished
	queue_free()
	
