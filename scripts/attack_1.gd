extends State

func enter():
	super.enter()
	attack()

func attack(move = "1"):
	animation_player.play("attack_" + move)
	await animation_player.animation_finished

func transition():
	if owner.direction.length() > 300:
		get_parent().change_state("Idle")
