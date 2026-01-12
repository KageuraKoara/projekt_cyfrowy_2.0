extends Node

@onready var projectile = load("res://Scenes/Projectile.tscn")
@onready var note_refs = [$Notes/C, $Notes/D, $Notes/E, $Notes/F, $Notes/G, $Notes/A, $Notes/B]

var song_position = 0.0
var song_position_in_beats = 0

var acc_points := 0.0
# enum keys_posY { C = 500, D = 460, E = 420, F = 380, G = 340, A = 300, B = 260 }
var keys_posY = [500, 460, 420, 380, 340, 300, 260, 220, 180, 140, 100, 60]
var attack_data_dics : Array[Dictionary] = [{}, {}, {}, {}, {}, {}, {}]

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
	print(acc_points * 10)
	print("WE DEAD!!!!!!!!!!!!!!!!!!!!!!!!!!")

func execute_attacks(attacks: Array[Dictionary]):
	for attack in attacks:
		for note in attack.notes:
			'double_check(note, attack)
			spawn_note(note, attack_data_dics[note])'
			spawn_note(note, attack)

func double_check(note: int, attack_data: Dictionary):
	if attack_data_dics[note].size() == 0:
		attack_data_dics[note] = attack_data
	else:
		var saved_type : String = attack_data_dics[note].get("type")
		print(attack_data_dics[note].get("type"))
		match saved_type:
			"single":
				attack_data_dics[note] = attack_data if attack_data.get("type") != saved_type else attack_data_dics[note]
			"interval":
				attack_data_dics[note] = attack_data if attack_data.get("type") == "chord" else attack_data_dics[note]
			"chord":
				attack_data_dics[note] = attack_data_dics[note]
	
	# return(attack_data_dics[note])

func spawn_note(note: int, attack_data: Dictionary):
	var instance = projectile.instantiate()

	instance.Direction = 0.0
	instance.PlayerX_Position = $Player.global_position.x
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
	
	if not note_refs[note].locked:
		add_child(instance)
		note_refs[note]._lock_note()
	attack_data_dics = [{}, {}, {}, {}, {}, {}, {}]
