extends Control

@onready var key_lvl: TextureRect = $Key_1
@onready var key_tut: TextureRect = $Key_tut
@onready var cutscene_0 = ""
@onready var cutscene_1 = "res://sprites/game/cutscenes/cutscene_level1.ogv"

var chosen_level : int

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("esc") and $cutscene_player.is_playing():
		$cutscene_player.stop()
		_on_cutscene_finished()

func _on_tutorial_pressed() -> void:
	chosen_level = 0
	_on_cutscene_finished()

func _on_level_1_pressed() -> void:
	chosen_level = 1
	$"../AudioStreamPlayer".stop()
	$"../ButtonsSfx".play()
	$cutscene_player.stream.set_file("res://sprites/game/cutscenes/cutscene_level1.ogv")
	$cutscene_player.visible = true
	$cutscene_player.play()

func _on_level_1_mouse_entered() -> void:
	key_lvl.visible = true

func _on_level_1_mouse_exited() -> void:
	key_lvl.visible = false

func _on_tutorial_mouse_exited() -> void:
	key_tut.visible = false

func _on_tutorial_mouse_entered() -> void:
	key_tut.visible = true

func _on_cutscene_finished() -> void:
	$cutscene_player.visible = false
	match chosen_level:
		0: get_tree().change_scene_to_file("res://scenes/levels/practice_level.tscn")
		1: get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")
