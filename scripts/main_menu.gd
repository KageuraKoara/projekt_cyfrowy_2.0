extends Control
@onready var key_settings: TextureRect = $Music_sheet/Key_settings
@onready var key_play: TextureRect = $Music_sheet/Key_play

func _on_play_pressed() -> void:
	$LevelMenu.visible = true if not $LevelMenu.visible else false
	# get_tree().change_scene_to_file("res://Scenes/UI/Main_Menu.tscn")

func _on_settings_pressed() -> void:
	$Settings.visible = true

func _on_credits_pressed() -> void:
	pass

func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_settings_mouse_entered() -> void:
	key_settings.visible = true

func _on_settings_mouse_exited() -> void:
	key_settings.visible = false


func _on_play_mouse_entered() -> void:
	key_play.visible = true
	
func _on_play_mouse_exited() -> void:
	key_play.visible = false
