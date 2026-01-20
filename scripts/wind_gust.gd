extends CharacterBody2D

func _ready() -> void:
	$Particles.wind()
	global_position.x = 700
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
	$Particles.stop_wimdy()
	await get_tree().create_timer(2).timeout
	queue_free()
