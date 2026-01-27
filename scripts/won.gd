extends "res://scripts/pause_menu.gd"


func _ready() -> void:
	$TimeTotal.text = str("Total time gained: " + str(SceneSharedData.time_total))
	$ChordsPlayed.text = str("Chords played: " + str(SceneSharedData.chords_played))
