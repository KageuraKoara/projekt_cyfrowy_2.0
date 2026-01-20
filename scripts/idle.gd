extends State

func enter():
	super.enter()
	raven_collision.set_deferred("disabled", true)
	default_collision.set_deferred("disabled", false)
	busy = false
	raven = false
	animation_player.play("idle")

func transition():
	'if Main.song_position_in_beats == 7:
		get_parent().change_state("Transform")'
	if Main.song_position_in_beats == 26 and not it_wimdy:
		spawn_wind()
	if Main.song_position_in_beats == 32:
		it_wimdy = false
		get_parent().change_state("Attack_3")
	if Main.song_position_in_beats == 48:
		get_parent().change_state("Attack_3")
		print("this was planned")
	if Main.song_position_in_beats == 82:
		get_parent().change_state("Attack_4")
	if Main.song_position_in_beats == 100:
		get_parent().change_state("Transform")
	if Main.song_position_in_beats == 136 and not it_wimdy:
		spawn_wind()
	if Main.song_position_in_beats == 172:
		it_wimdy = false
		get_parent().change_state("Attack_4")
	if Main.song_position_in_beats == 190 and not it_wimdy:
		spawn_wind()
	if Main.song_position_in_beats == 220:
		it_wimdy = false
		get_parent().change_state("Transform")
	if Main.song_position_in_beats == 260:
		get_parent().change_state("Attack_4")
	if Main.song_position_in_beats == 290:
		get_parent().change_state("Transform")
	if Main.song_position_in_beats == 310 and not it_wimdy:
		spawn_wind()
	
	# minor attacks
	if $"../..".player_in_range:
		get_parent().change_state("Attack_1")
	if not busy and attackCD_timer.is_stopped():
		var chance = randi() % 2
		match chance:
			0:
				get_parent().change_state("Attack_2")
			1:
				get_parent().change_state("Attack_3")
