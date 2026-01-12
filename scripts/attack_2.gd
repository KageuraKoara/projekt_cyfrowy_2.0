extends State

@export var ink_splash_node : PackedScene
var can_transition := false

func enter():
	super.enter()
	animation_player.play("attack_2")
	await animation_player.animation_finished
	can_transition = true

func spawn():
	var min_x = player.global_position.x - 100 # -1200, -20
	var ink_splash = ink_splash_node.instantiate()
#	ink_splash.position = owner.position + Vector2(x, 0)
	ink_splash.position.x = randi_range(min_x, 700)
	ink_splash.position.y = 440
	print(min_x)
	Main.add_child(ink_splash)

func transition():
	if can_transition:
		get_parent().change_state("Idle")
		can_transition = false
