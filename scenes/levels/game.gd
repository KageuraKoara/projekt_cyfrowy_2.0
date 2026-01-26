extends Node

@onready var projectile = load("res://Scenes/Projectile.tscn")
@onready var note_refs = [$Notes/C, $Notes/D, $Notes/E, $Notes/F, $Notes/G, $Notes/A, $Notes/B]
@onready var ui_hourglass = $CanvasLayer/Hourglass

var song_position = 0.0
var song_position_in_beats = 0

var acc_points := 0.0
var keys_posY = [500, 460, 420, 380, 340, 300, 260, 220, 180, 140, 100, 60]

func _ready():
	$Conductor.play_with_beat_offset(0)
	$Start.play()
func _on_Conductor_beat(position):
	song_position_in_beats = position
	$CanvasLayer/CompositionProgress.value = song_position_in_beats
	if song_position_in_beats >= 360: you_win()

func _on_death_hit(_note: float, HP: float) -> void:
	ui_hourglass.add_time(HP)

func _on_got_hit(attack, HP):
	print("ayaya got hit by ", attack, " for ", HP, " hp")
	ui_hourglass.remove_time(HP)
	$Player._on_damage()

func execute_attacks(attacks: Array[Dictionary]):
	for attack in attacks:
		for note in attack.notes:
			note_refs[note].spawn(note, attack)

func spawn_note(note: int, attack_data: Dictionary):
	$Player.play_attack()
	var instance = projectile.instantiate()

	instance.Direction = 0.0
	instance.PlayerX_Position = $Player.global_position.x + 50
	instance.note = note
	instance.type = attack_data.type
	instance.pos_y = keys_posY

	instance.speed_multiplier = attack_data.speed_mult * note_refs[note].spam_mult
	instance.HP = attack_data.HP * note_refs[note].spam_mult
	
	$ProjectileLayer.add_child(instance)

func _on_hourglass_your_time_ran_out() -> void:
	$Player.death()

func you_win():
	get_tree().change_scene_to_file("res://Scenes/UI/Won.tscn")
