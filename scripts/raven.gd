extends State

func enter():
	super.enter()
	owner.set_physics_process(true)
	animation_player.play("raven")

func exit():
	super.exit()
	owner.set_physics_process(false)

func transition():
	if $"../..".player_in_range:
		get_parent().change_state("Attack_5")
