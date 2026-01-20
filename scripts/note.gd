extends AnimatedSprite2D

@onready var Main = get_tree().get_root().get_node("Level1")
@onready var chord_manager = $"../../ChordManager"

@export var stave_line : AnimatedSprite2D
@export var input := ""
@export var id : int
@export var comboTime := 0.15
@export var pitch: AudioStreamWAV

var locked := false
var spam_mult := 1.2

var times_spawned := 0
var attacks : Array[Dictionary] = []

func _ready() -> void:
	$ComboTimer.wait_time = comboTime
	$NoteSound.stream = pitch

func get_played_idiot():
	$NoteSound.play()
	$ComboTimer.start()
	$SpamTimer.start()
	spam_mult -= 0.2 if spam_mult >= 0.2 else 0.0
	if not stave_line.locked:
		stave_line.resolve(1 * spam_mult)

func spawn(note: int, attack_data: Dictionary):
	if times_spawned == 0: $TypeCheckTimer.start()
	times_spawned += 1
	
	attacks.append(attack_data)

func _on_type_check_timeout() -> void:
	var attack_data: Dictionary
	var intv_found := false
	
	for attack in attacks:
		if attack.type != "chord":
			if attack.type != "interval" and not intv_found:
				attack_data = attack
			else:
				attack_data = attack
				intv_found = true
		else: 
			attack_data = attack
			break
	
	Main.spawn_note(id, attack_data)
	get_played_idiot()
	times_spawned = 0
	attacks.clear()


func _on_combo_timer_timeout() -> void:
	chord_manager.clear_note(id)

func _on_spam_timer_timeout() -> void:
	spam_mult = 1.2
