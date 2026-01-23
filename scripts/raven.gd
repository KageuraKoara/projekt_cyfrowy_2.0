extends State
var audio = preload("res://sounds/Death/Raven/Trigger.wav")
func enter():
	super.enter()
	owner.set_physics_process(true)
	animation_player.play("raven")
	raven_collision.set_deferred("disabled", false)
	default_collision.set_deferred("disabled", true)

func exit():
	super.exit()
	owner.set_physics_process(false)

func transition():
	if $"../..".player_in_range:
		$"../../AudioStreamPlayer".stream = audio
		$"../../AudioStreamPlayer".play()
		get_parent().change_state("Attack_5")
