extends AnimatedSprite2D

@onready var Main = get_tree().get_root().get_node("Level1")

func _ready() -> void:
	play("splash")

func _on_hurt_timer_timeout() -> void:
	$Area2D/CollisionShape2D.set_deferred("disabled", false)
	die()

func _on_ink_splash_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Main._on_got_hit("ink_splash", 15.0)

func die():
	await get_tree().create_timer(0.5).timeout
	queue_free()
