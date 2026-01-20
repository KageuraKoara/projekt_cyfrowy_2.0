extends State

var can_transition := false

func enter():
	super.enter()
	is_busy(true, 0.0)
	animation_player.play("attack_4")
	await animation_player.animation_finished
	can_transition = true

func transition():
	if can_transition:
		get_parent().change_state("Idle")
		can_transition = false
