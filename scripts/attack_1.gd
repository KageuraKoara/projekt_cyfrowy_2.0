extends State

func enter():
	super.enter()
	attack()

func exit():
	super.exit()

func attack(move = "1"):
	animation_player.play("attack_" + move)
	await animation_player.animation_finished

func transition():
	if !$"../..".player_in_range:
		get_parent().change_state("Idle")
