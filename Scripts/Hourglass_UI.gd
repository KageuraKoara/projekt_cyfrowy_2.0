extends VSlider


@export var lvl1: Node
@onready var top: VSlider = $"."
@onready var bottom: VSlider = $"../Bottom"
const Game = preload("res://Scenes/levels/game.gd")

@onready var song_timer: HSlider = $"../../Song_timer"

@export var song = preload("res://sounds/Concerto In G Minor for Violin, String Orchestra and Continuo, Op. 8, No. 2, RV 315, Lestate....mp3")

var song_length = song.get_length()


func _process(delta: float) -> void:
	top.max_value = song_length
	bottom.max_value = song_length
	song_timer.max_value = song_length
	song_timer.value = lvl1.song_position_in_beats

func _on_value_changed() -> void:
	top.value = $Hourglass.wait_time
	bottom.value = max_value - top.value
	
