extends Control

@onready var player_script = load("res://scripts/player.gd")

func _process(delta: float) -> void:
	esc_hide()

func esc_hide():
	if Input.is_action_just_pressed("esc"):
		visible = false

'func _on_left_toggled(toggled_on: bool) -> void:
	player_script.left_input = "movement_A" if toggled_on else "movement_Q"
	print("is left non-default?? ", toggled_on)

func _on_jump_toggled(toggled_on: bool) -> void:
	player_script.jump_input = "movement_W" if toggled_on else "movement_Space"
	print("is jump non-default?? ", toggled_on)

func _on_right_toggled(toggled_on: bool) -> void:
	player_script.right_input = "movement_D" if toggled_on else "movement_P"
	print("is right non-default?? ", toggled_on)
'
