extends Control

func _on_tutorial_pressed() -> void:
	pass
	# get_tree().change_scene_to_file("res://scenes/levels/tutorial.tscn")

func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")
