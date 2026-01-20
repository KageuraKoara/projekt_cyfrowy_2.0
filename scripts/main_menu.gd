extends Control

func _on_play_pressed() -> void:
	$LevelMenu.visible = true if not $LevelMenu.visible else false
	# get_tree().change_scene_to_file("res://Scenes/UI/Main_Menu.tscn")

func _on_settings_pressed() -> void:
	$Settings.visible = true

func _on_credits_pressed() -> void:
	pass

func _on_exit_pressed() -> void:
	get_tree().quit()
