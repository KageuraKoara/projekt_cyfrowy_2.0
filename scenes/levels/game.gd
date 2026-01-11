extends Node

@onready var projectile = load("res://Scenes/Projectile.tscn")
@onready var note_refs = [$Notes/C, $Notes/D, $Notes/E, $Notes/F, $Notes/G, $Notes/A, $Notes/B]

var song_position = 0.0
var song_position_in_beats = 0

enum keys_posY { C = 500, D = 460, E = 420, F = 380, G = 340, A = 300, B = 260 }

func _ready():
	$Conductor.play_with_beat_offset(12)

func _on_Conductor_beat(position):
	song_position_in_beats = position

func _on_death_hit(_note: float, HP: float) -> void:
	$Hourglass.add_time(HP)

func _on_got_hit(attack, HP):
	print("ayaya got hit by ", attack, " for ", HP, " hp")
	$Hourglass.remove_time(HP)

func _on_hourglass_time_ran_out() -> void:
	print("WE DEAD!!!!!!!!!!!!!!!!!!!!!!!!!!")

func execute_attacks(attacks: Array[Dictionary]):
	for attack in attacks:
		for note in attack.notes:
			spawn_note(note, attack)

func spawn_note(note: int, attack_data: Dictionary):
	var instance = projectile.instantiate()

	instance.Direction = $Player.note_direction
	instance.PlayerX_Position = $Player.global_position.x
	instance.Spawn_Rotation = $Player.rotation
	instance.note = note

	instance.speed_multiplier = attack_data.speed_mult * note_refs[note].spam_mult
	instance.HP = attack_data.HP * note_refs[note].spam_mult
	if attack_data.type == "chord":
		instance.frame = 2
	elif attack_data.type == "interval":
		instance.frame = 1
	else:
		instance.frame = 0

	add_child(instance)
