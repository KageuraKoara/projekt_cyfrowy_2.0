extends State
var audio = preload("res://sounds/Death/Raven/Szarża.wav")
var has_charged := false

func enter():
	super.enter()
	detection_collision.scale = Vector2(0.3, 0.3)
	attack()

func exit():
	detection_collision.scale = Vector2(1, 1)
	super.exit()

func attack(move = "5"):
	var t = create_tween()
	$"../../AudioStreamPlayer".stream = audio
	$"../../AudioStreamPlayer".play()
	animation_player.play("attack_" + move)
	t.tween_property(owner, "global_position:x", global_position.x - 300, 0.5)
	await animation_player.animation_finished
	has_charged = true
	owner.global_position.x += 400

func transition():
	if has_charged:
		if get_parent().raven_charge_count < 2:
			get_parent().change_state("Raven")
			get_parent().raven_charge_count += 1
			has_charged = false
		else:
			$"../..".global_position = $"../..".default_position
			get_parent().change_state("Idle")
			get_parent().raven_charge_count = 0
	
