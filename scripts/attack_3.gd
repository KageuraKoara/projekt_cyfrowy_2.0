extends State

@export var ink_raven_node : PackedScene
var can_transition := false

func enter():
	super.enter()
	animation_player.play("attack_3")
	await animation_player.animation_finished
	can_transition = true

func spawn():
	var ink_raven = ink_raven_node.instantiate()
	ink_raven.position = owner.position + Vector2(20, 40)
	pr_layer.add_child(ink_raven)

func transition():
	if can_transition:
		get_parent().change_state("Idle")
		can_transition = false
