extends Control

@onready var player_script = load("res://scripts/player.gd")

func _process(delta: float) -> void:
	esc_hide()

func esc_hide():
	if Input.is_action_just_pressed("esc"):
		visible = false

func _on_left_toggled(toggled_on: bool) -> void:
	SceneSharedData.input_left = "movement_A" if toggled_on else "movement_Q"
	$"../ButtonsSfx".play()

func _on_jump_toggled(toggled_on: bool) -> void:
	SceneSharedData.input_jump = "movement_W" if toggled_on else "movement_Space"
	$"../ButtonsSfx".play()

func _on_right_toggled(toggled_on: bool) -> void:
	SceneSharedData.input_right = "movement_D" if toggled_on else "movement_P"
	$"../ButtonsSfx".play()
