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
	elif Input.is_action_just_pressed("esc") and get_tree().paused:
		resume()

func _on_resume_pressed() -> void:
	resume()

func _on_restart_pressed() -> void:
	if name == "Pause":
		get_tree().reload_current_scene()
	else:
		get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")

func _on_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/UI/Main_Menu.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
