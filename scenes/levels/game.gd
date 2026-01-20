extends Node

@onready var projectile = load("res://Scenes/Projectile.tscn")
@onready var note_refs = [$Notes/C, $Notes/D, $Notes/E, $Notes/F, $Notes/G, $Notes/A, $Notes/B]

var song_position = 0.0
var song_position_in_beats = 0

var acc_points := 0.0
var keys_posY = [500, 460, 420, 380, 340, 300, 260, 220, 180, 140, 100, 60]

func _ready():
	$Conductor.play_with_beat_offset(0)

func _on_Conductor_beat(position):
	song_position_in_beats = position

func _on_death_hit(_note: float, HP: float) -> void:
	$Hourglass.add_time(HP)

func _on_got_hit(attack, HP):
	print("ayaya got hit by ", attack, " for ", HP, " hp")
	$Hourglass.remove_time(HP)
	$Player._on_damage()

func _on_hourglass_time_ran_out() -> void:
	print(acc_points * 10)
	$Player.death()

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
	if attack_data.type == "chord":
		instance.frame = 2
	elif attack_data.type == "interval":
		instance.frame = 1
	else:
		instance.frame = 0
	
	$ProjectileLayer.add_child(instance)
