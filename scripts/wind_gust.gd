extends CharacterBody2D


func _ready() -> void:
	$AnimatedSprite2D.play("idle")
	global_position.x = 500
	global_position.y = 460

func _on_phase_change() -> void:
	global_position.y = 300

func _on_detection_area_entered(body: Node2D) -> void:
	if body.is_in_group("projectile"):
		body.get_rotated_idiot()
	elif body.is_in_group("player"):
		body._on_knockback(300)

func _on_despawn_timeout() -> void:
	despawn()

func despawn():
	queue_free()
