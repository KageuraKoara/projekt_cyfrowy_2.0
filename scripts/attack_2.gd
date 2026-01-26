extends State
const Rain_out = preload("res://sounds/Death/Rain/Odwołanie deszczu.wav")
const Rain_in = preload("res://sounds/Death/Rain/Przywołanie deszczu.wav")
const RAIN_AMBIENT = preload("res://sounds/Death/Rain/Rain Ambient.wav")
@export var ink_splash_node : PackedScene
var can_transition := false

func enter():
	super.enter()
	$"../../Rain".stream = Rain_in
	$"../../Rain".play()
	animation_player.play("attack_2")
	await animation_player.animation_finished
	can_transition = true
	$"../../AudioStreamPlayer".stream = RAIN_AMBIENT
	$"../../AudioStreamPlayer".play()
	$"../../Scythe".play()

func spawn():
	var min_x = player.global_position.x - 300
	var ink_splash = ink_splash_node.instantiate()
	ink_splash.position.x = randi_range(min_x, 1100)
	ink_splash.position.y = 440
	pr_layer.add_child(ink_splash)

func transition():
	if can_transition:
		$"../../AudioStreamPlayer".stop()
		$"../../Rain".stream = Rain_out
		$"../../Rain".play()
		get_parent().change_state("Idle")
		can_transition = false
