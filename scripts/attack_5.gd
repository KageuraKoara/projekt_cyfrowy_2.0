extends State

var has_charged := false

func enter():
	super.enter()
	$"../../PlayerDetection/CollisionShape2D".scale = Vector2(0.3, 0.3)
	attack()

func exit():
	$"../../PlayerDetection/CollisionShape2D".scale = Vector2(1, 1)
	super.exit()

func attack(move = "5"):
	var t = create_tween()
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
			print(get_parent().raven_charge_count)
		else:
			$"../..".global_position = $"../..".default_position
			get_parent().change_state("Idle")
			get_parent().raven_charge_count = 0
	
