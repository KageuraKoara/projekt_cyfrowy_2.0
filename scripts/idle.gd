extends State

@onready var collision = $"../../PlayerDetection/CollisionShape2D"

'var player_entered : bool = false
:
	set(value):
		player_entered = value
		collision.set_deferred("disabled", value)

func _on_player_detected(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_entered = true'

func enter():
	super.enter()
	animation_player.play("idle")

func transition():
	if Main.song_position_in_beats == 12:
		get_parent().change_state("Transform")
	if $"../..".player_in_range:
		get_parent().change_state("Attack_1")
