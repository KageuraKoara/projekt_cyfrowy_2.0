extends Node

@onready var projectile = load("res://Scenes/Projectile.tscn")

var song_position = 0.0
var song_position_in_beats = 0

var inputsPressed = []
var activeCombo : String

'var keys = [
	{
		"key": "E",
		"active": func(): return $Notes/C.comboing
	},
	{
		"key": "R",
		"active": func(): return $Notes/D.comboing
	},
	{
		"key": "T",
		"active": func(): return $Notes/E.comboing
	},
	{
		"key": "Y",
		"active": func(): return $Notes/F.comboing
	},
	{
		"key": "U",
		"active": func(): return $Notes/G.comboing
	},
	{
		"key": "I",
		"active": func(): return $Notes/A.comboing
	},
	{
		"key": "O",
		"active": func(): return $Notes/H.comboing
	}
]

var patterns = [
	{
		"name": "CD",
		"active": false,
		"start": [1, 99],
		"end": [36, 132],
		"inputs": ["E", "R"],
		"time_damage": 2.0,
		"effect": func(): pass
	},
	{
		"name": "CE",
		"active": false,
		"start": [1, 37, 99],
		"end": [36, 98, 132],
		"inputs": ["E", "T"],
		"time_damage": 3.0,
		"effect": func(): pass
	},
	{
		"name": "CF",
		"active": false,
		"start": [1, 37, 133],
		"end": [36, 98, 162],
		"inputs": ["E", "Y"],
		"time_damage": 5.0,
		"effect": func(): pass
	},
	{
		"name": "CEG",
		"active": false,
		"start": [1],
		"end": [162],
		"inputs": ["E", "T", "U"],
		"time_damage": 5.0,
		"effect": func(): $Player.StartDashTimer()
	}
]'


func _ready():
	$Conductor.play_with_beat_offset(12)

func _physics_process(delta: float) -> void:
	update_inputsPressed()
	detect_combos()

func update_inputsPressed():
	for k in range($References.keys.size()):
		if $References.keys[k].active.call():
			if !inputsPressed.has($References.keys[k].key):
				inputsPressed.append($References.keys[k].key)
			else:
				pass
		else:
			inputsPressed.erase($References.keys[k].key)

func detect_combos():
	for i in range($References.patterns.size()):
		$References.patterns[i].active = false
		
		for n in range($References.patterns[i].start.size()):
			if song_position_in_beats >= $References.patterns[i].start[n] and song_position_in_beats <= $References.patterns[i].end[n]:
				$References.patterns[i].active = true
				break
		
		if $References.patterns[i].inputs == inputsPressed && $References.patterns[i].active:
			print($References.patterns[i].name)
			$References.patterns[i].effect.call()
			activeCombo = str($References.patterns[i].inputs)
			combo_notes_data()
		else:
			pass

func _on_Conductor_beat(position):
	song_position_in_beats = position

func combo_notes_data():
	pass
	# parameters to make for this function: time damage (from patterns[]), frame (0 or 1??)

func Notes(input):
	var instance = projectile.instantiate()
	instance.Direction = $Player.rotation
	instance.Spawn_Position = Vector2($Player.global_position.x, instance.keys_posY[input])
	instance.Spawn_Rotation = $Player.rotation
	instance.note = input
	if input in activeCombo: # this is vv cursed, we need to replace activeCombo with something better ToT
		instance.frame = 1
		instance.time_damage = 5.0 #for tests
	$".".add_child(instance)

# time_damage * ilość_kliknięć = stopniowe zmniejszanie damage'u spamowanych nut

func _on_death_owie(note: String, time_damage: float) -> void:
	$Hourglass.add_time(time_damage)

func _on_hourglass_time_ran_out() -> void:
	print("WE DEAD!!!!!!!!!!!!!!!!!!!!!!!!!!")
