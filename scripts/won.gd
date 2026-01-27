extends "res://scripts/pause_menu.gd"


func _ready() -> void:
	$TimeTotal.text = str("Total Time: " + str(roundi(SceneSharedData.time_total)) + " sec")
	$ChordsPlayed.text = str("Chords Played: " + str(SceneSharedData.chords_played))
