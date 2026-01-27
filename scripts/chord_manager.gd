extends Node

@onready var Main = get_tree().get_root().get_node("Level1")
@onready var player = get_parent().find_child("Player")
@onready var note_refs = [$"../Notes/C", $"../Notes/D", $"../Notes/E", $"../Notes/F", $"../Notes/G", $"../Notes/A", $"../Notes/B"]
@onready var hourglass = $"../CanvasLayer/Hourglass"

enum EnumNote { C, D, E, F, G, A, B }

var inputs_pressed : Array[int] = []
var resolve_requested := false
var nb_value := 1.0
var note_boost := nb_value
var notes_in_scene : Array = []

var CHORDS := [
	{
		"id": "C_DUR",
		"cd_timer": func(): return $CEG_Timer.is_stopped(),
		"start_cd": func(): $CEG_Timer.start(),
		"notes": [EnumNote.C, EnumNote.E, EnumNote.G],
		"HP": 5.0,
		"speed_mult": 1.3,
		"effect": "dash"
		},
	{
		"id": "D_MOLL",
		"cd_timer": func(): return $DFA_Timer.is_stopped(),
		"start_cd": func(): $DFA_Timer.start(),
		"notes": [EnumNote.D, EnumNote.F, EnumNote.A],
		"HP": 5.0,
		"speed_mult": 1.3,
		"effect": "super_jump"
		},
	{
		"id": "E_MOLL",
		"cd_timer": func(): return $EGB_Timer.is_stopped(),
		"start_cd": func(): $EGB_Timer.start(),
		"notes": [EnumNote.E, EnumNote.G, EnumNote.B],
		"HP": 5.0,
		"speed_mult": 1.3,
		"effect": "note_boost"
	}
]

func _process(delta: float) -> void:
	inputs_pressed.sort()
	
	if resolve_requested:
		var attacks := resolve_combos(inputs_pressed)
		if attacks.size() > 0:
			Main.execute_attacks(attacks)
		resolve_requested = false

func _unhandled_input(event: InputEvent) -> void:
	for note in note_refs:
		if event.is_action_pressed(note.input, false):
			resolve_requested = true
			if !inputs_pressed.has(note.id):
				inputs_pressed.append(note.id)
			else:
				pass

func clear_note(note: int):
	inputs_pressed.erase(note)

func interval_HP(distance: int) -> float:
	return 1.0 + (distance * 0.25)

func update_note_boost():
	notes_in_scene = get_tree().get_nodes_in_group("projectile")
	var count := notes_in_scene.size()
	
	if count >= 5:
		note_boost = nb_value - 0.2 * int(count/5)
	else:
		note_boost = nb_value

# the big boy section

func resolve_combos(pressed_notes: Array[int]) -> Array[Dictionary]:
	var result: Array[Dictionary] = []
	var available := pressed_notes.duplicate()
	
	update_note_boost()

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
		perform_chord_effect(played_chord.effect)
		result.append({
			"type": "chord",
			"notes": played_chord.notes.duplicate(),
			"HP": played_chord.HP * note_boost,
			"speed_mult": played_chord.speed_mult * note_boost,
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
				"HP": interval_HP(best_distance) * note_boost,
				"speed_mult": 1.1 * note_boost
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
		"HP": 0.5 * note_boost,
		"speed_mult": 1.0 * note_boost
	}

func perform_chord_effect(effect):
	SceneSharedData.chords_played += 1
	if effect == "dash":
		player.StartDashTimer()
		$"../CanvasLayer/CEG_cd_indicator".cd_start()
	elif effect == "super_jump":
		player.StartSJumpTimer()
		$"../CanvasLayer/DFA_cd_indicator".cd_start()
	elif effect == "note_boost":
		nb_value = 1.3
		player.note_boost_glow(true)
		hourglass.hp_ind_color = Color(0.933, 0.377, 0.497)
		$NoteBoostTimer.start()
		$"../CanvasLayer/EGB_cd_indicator".cd_start()

func _on_note_boost_timeout() -> void:
	nb_value = 1.0
	player.note_boost_glow(false)
	hourglass.hp_ind_color = Color(1, 1, 1)
