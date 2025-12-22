extends Area2D

signal owie(note: String, time_damage: float)


func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	emit_signal("owie", body.note, body.time_damage)
	# print("owie")
