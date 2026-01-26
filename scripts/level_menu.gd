extends Control
@onready var key_lvl: TextureRect = $Key_1
@onready var key_tut: TextureRect = $Key_tut

func _on_tutorial_pressed() -> void:
	pass
	# get_tree().change_scene_to_file("res://scenes/levels/tutorial.tscn")

func _on_level_1_pressed() -> void:
	$"../ButtonsSfx".play()
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")

func _on_level_1_mouse_entered() -> void:
	key_lvl.visible = true

func _on_level_1_mouse_exited() -> void:
	key_lvl.visible = false

func _on_tutorial_mouse_exited() -> void:
	key_tut.visible = false

func _on_tutorial_mouse_entered() -> void:
	key_tut.visible = true
