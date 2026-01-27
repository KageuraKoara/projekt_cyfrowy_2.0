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
		get_parent().change_state("Transform")' # STATE DEBUG LINE
	if Main.song_position_in_beats == 24 and not it_wimdy:
		spawn_wind()
	if Main.song_position_in_beats == 52:
		it_wimdy = false
		get_parent().change_state("Attack_3")
	if Main.song_position_in_beats == 54:
		get_parent().change_state("Attack_3")
	if Main.song_position_in_beats == 57:
		get_parent().change_state("Attack_3")
	if Main.song_position_in_beats == 61:
		get_parent().change_state("Attack_3")
	if Main.song_position_in_beats == 63:
		get_parent().change_state("Attack_3")
	if Main.song_position_in_beats == 66:
		get_parent().change_state("Attack_3")
	if Main.song_position_in_beats == 68:
		get_parent().change_state("Attack_3")
	if Main.song_position_in_beats == 70:
		get_parent().change_state("Attack_3")
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
	if Main.song_position_in_beats >= 360: # 360:
		Main.you_win()
	
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
