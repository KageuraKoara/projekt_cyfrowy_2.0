extends State

@onready var collision = $"../../PlayerDetection/CollisionShape2D"

func enter():
	super.enter()
	animation_player.play("idle")

func transition():
	if Main.song_position_in_beats == 12:
		get_parent().change_state("Transform")
	if $"../..".player_in_range:
		get_parent().change_state("Attack_1")
