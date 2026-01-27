extends Node

@onready var projectile = load("res://Scenes/Projectile.tscn")
@onready var note_refs = [$Notes/C, $Notes/D, $Notes/E, $Notes/F, $Notes/G, $Notes/A, $Notes/B]
@onready var ui_hourglass = $CanvasLayer/Hourglass

var song_position = 0.0
var song_position_in_beats = 0

var acc_points := 0.0
var keys_posY = [500, 460, 420, 380, 340, 300, 260, 220, 180, 140, 100, 60]

func _ready():
	$Start.play()

func _on_training_dummy_hit(body: Node2D) -> void:
	if body.is_in_group("projectile"):
		ui_hourglass.add_time(body.HP)
		body.despawn()

func _on_got_hit(attack, HP):
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
