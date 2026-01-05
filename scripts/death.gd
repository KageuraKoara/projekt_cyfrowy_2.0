extends CharacterBody2D

@onready var player = get_parent().find_child("Player")
@onready var animated_sprite = $AnimatedSprite2D

var direction : Vector2

signal death_hit(note: String, HP: float)

func _ready() -> void:
	set_physics_process(false)

func _process(delta: float) -> void:
	direction = player.position - position
	
	if direction.x > 0:
		animated_sprite.flip_h = true
	else:
		animated_sprite.flip_h = false

func _on_owie(note: float, HP: float) -> void:
	emit_signal("death_hit", note, HP)

func hitting(attack_type):
	print("get hit idiottt")
