extends Node

@onready var Main = get_tree().get_root().get_node("Level1")
@onready var C = get_parent().find_child("C")
@onready var D = get_parent().find_child("D")
@onready var E = get_parent().find_child("E")
@onready var F = get_parent().find_child("F")
@onready var G = get_parent().find_child("G")
@onready var A = get_parent().find_child("A")
@onready var B = get_parent().find_child("B")

@onready var Notes = [C, D, E, F, G, A, B]
enum EnumNote { C, D, E, F, G, A, B }

var inputsPressed : Array[int] = []
var resolve_requested := false

var CHORDS := [
	{
		"id": "C_DUR",
		"cd_timer": func(): return $CDUR_Timer.is_stopped(),
		"start_cd": func(): $CDUR_Timer.start(),
		"notes": [EnumNote.C, EnumNote.E, EnumNote.G],
		"HP": 5.0,
		"speed_mult": 1.3,
		},
	{
		"id": "D_MOLL",
		"cd_timer": func(): return $DMOLL_Timer.is_stopped(),
		"start_cd": func(): $DMOLL_Timer.start(),
		"notes": [EnumNote.D, EnumNote.F, EnumNote.A],
		"HP": 5.0,
		"speed_mult": 1.3,
		},
	{
		"id": "E_MOLL",
		"cd_timer": func(): return $EMOLL_Timer.is_stopped(),
		"start_cd": func(): $EMOLL_Timer.start(),
		"notes": [EnumNote.E, EnumNote.G, EnumNote.B],
		"HP": 5.0,
		"speed_mult": 1.3,
	}
]

func _physics_process(delta: float) -> void:
	update_inputsPressed()
	
	if resolve_requested:
		var attacks := resolve_combos(inputsPressed)
		if attacks.size() > 0:
			Main.execute_attacks(attacks)
		inputsPressed.clear()
		resolve_requested = false

func _unhandled_input(event: InputEvent) -> void:
	for note in Notes:
		if event.is_action_pressed(note.input, false):
			resolve_requested = true
			note.get_played_idiot(note.input)

func update_inputsPressed():
	for note in Notes:
		var temp = EnumNote.get(str(note).left(1))
		if note.comboing:
			if !inputsPressed.has(temp):
				inputsPressed.append(temp)
			else:
				pass
		else:
			inputsPressed.erase(temp)
		inputsPressed.sort()

func interval_HP(distance: int) -> float:
	return 1.0 + (distance * 0.25)

func resolve_combos(pressed_notes: Array[int]) -> Array[Dictionary]:
	var result: Array[Dictionary] = []
	var available := pressed_notes.duplicate()

	if available.size() > 4:
		for note in available:
			result.append(_single_note_attack(note))
		return result
	

	var played_chord = null
	
	for chord in CHORDS:
		if chord.cd_timer.call():
			var has_all := true
			for n in chord.notes:
				if not available.has(n):
					has_all = false
					break
					
			if has_all:
				played_chord = chord
				break
	
	if played_chord:
		result.append({
			"type": "chord",
			"notes": played_chord.notes.duplicate(),
			"HP": played_chord.HP,
			"speed_mult": played_chord.speed_mult,
			"chord_id": played_chord.id
		})
		
		for n in played_chord.notes:
			available.erase(n)
		
		played_chord.start_cd.call()
	
	
	if available.size() >= 2:
		var best_pair := []
		var best_distance := -1
		
		for i in range(available.size()):
			for j in range(i + 1, available.size()):
				var a = available[i]
				var b = available[j]
				var dist = abs(a - b)
				
				if dist > best_distance:
					best_distance = dist
					best_pair = [a, b]
				
		if best_pair.size() == 2:
			result.append({
				"type": "interval",
				"notes": best_pair,
				"distance": best_distance,
				"HP": interval_HP(best_distance),
				"speed_mult": 1.1
			})
			
			available.erase(best_pair[0])
			available.erase(best_pair[1])
	
	
	
	for note in available:
		result.append(_single_note_attack(note))
	
	return result

func _single_note_attack(note: int) -> Dictionary:
	return {
		"type": "single",
		"notes": [note],
		"HP": 0.5,
		"speed_mult": 1.0
	}
