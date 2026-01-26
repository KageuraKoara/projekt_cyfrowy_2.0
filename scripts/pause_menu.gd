extends Control

func resume():
	get_tree().paused = false
	visible = false

func pause():
	get_tree().paused = true
	visible = true

func _process(delta: float) -> void:
	if name == "Pause":
		esc_pause()

func esc_pause():
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		pause()
		$ButtonsSfx.play()
	elif Input.is_action_just_pressed("esc") and get_tree().paused:
		resume()
		$ButtonsSfx.play()

func _on_resume_pressed() -> void:
	$ButtonsSfx.play()
	resume()

func _on_restart_pressed() -> void:
	if name == "Pause":
		get_tree().reload_current_scene()
		$ButtonsSfx.play()
	else:
		get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")

func _on_menu_pressed() -> void:
	get_tree().paused = false
	$ButtonsSfx.play()
	get_tree().change_scene_to_file("res://scenes/UI/Main_Menu.tscn")

func _on_exit_pressed() -> void:
	$ButtonsSfx.play()
	get_tree().quit()


func _on_result_ready() -> void:
	$result.play()

func _on_result_won_ready() -> void:
	$Result_won.play()
