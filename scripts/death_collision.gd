extends Area2D

signal owie(note: float, HP: float)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("projectile"):
		emit_signal("owie", body.note, body.HP)
