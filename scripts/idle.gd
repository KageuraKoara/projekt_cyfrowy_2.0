extends State

func enter():
	super.enter()
	raven_collision.set_deferred("disabled", true)
	default_collision.set_deferred("disabled", false)
	busy = false
	animation_player.play("idle")

func transition():
	if Main.song_position_in_beats == 12:
		get_parent().change_state("Transform")
	if $"../..".player_in_range:
		get_parent().change_state("Attack_1")
	if not busy and attackCD_timer.is_stopped():
		get_parent().change_state("Attack_3")
		'var chance = randi() % 2
		match chance:
			0:
				get_parent().change_state("Attack_2")
			1:
				get_parent().change_state("Attack_3")'
