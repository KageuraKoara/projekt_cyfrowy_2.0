extends State

var transformed := false

func enter():
	super.enter()
	death_transform()

func exit():
	super.exit()

func death_transform():
	animation_player.play("transform")
	await animation_player.animation_finished
	transformed = true

func transition():
	if transformed:
		get_parent().change_state("Raven")
