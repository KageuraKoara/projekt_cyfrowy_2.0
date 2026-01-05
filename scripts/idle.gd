extends State

@onready var collision = $"../../PlayerDetection/CollisionShape2D"

var player_entered : bool = false:
	set(value):
		player_entered = value
		collision.set_deferred("disabled", value)

func _on_player_detected(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_entered = true

func _on_player_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_entered = false

func transition():
	if player_entered:
		get_parent().change_state("Attack1")
	else:
		get_parent().change_state("Idle")
