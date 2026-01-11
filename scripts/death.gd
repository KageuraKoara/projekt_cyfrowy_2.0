extends CharacterBody2D

@onready var Main = get_tree().get_root().get_node("Level1")
@onready var player = get_parent().find_child("Player")
@onready var animated_sprite = $AnimatedSprite2D

var direction : Vector2
var player_in_range := false
var default_position := Vector2(800, 440)

signal death_hit(note: String, HP: float)

func _ready() -> void:
	global_position = default_position
	set_physics_process(false)

func _process(delta: float) -> void:
	direction = player.position - position
	
	if direction.x > 0:
		animated_sprite.flip_h = true
	else:
		animated_sprite.flip_h = false

func _physics_process(delta: float) -> void:
	velocity = direction.normalized() * 80
	move_and_collide(velocity * delta)

func _on_owie(note: float, HP: float) -> void:
	emit_signal("death_hit", note, HP)

func hitting(attack_type : String, HP : float):
	if player_in_range:
		Main._on_got_hit(attack_type, HP)

func knockback(push : int):
	if player_in_range:
		player._on_knockback(push)

func _on_player_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true

func _on_player_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false
