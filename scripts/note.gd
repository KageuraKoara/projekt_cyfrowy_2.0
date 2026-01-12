extends AnimatedSprite2D

@onready var Main = get_tree().get_root().get_node("Level1")

@export var stave_line : AnimatedSprite2D
@export var input = ""
@export var comboTime = 0.15
@export var pitch: AudioStreamWAV

var locked := false
var comboing := false
var spam_mult := 1.2

func _ready() -> void:
	$ComboTimer.wait_time = comboTime
	$NoteSound.stream = pitch

func get_played_idiot(_input):
	$NoteSound.play()
	$ComboTimer.start()
	$SpamTimer.start()
	comboing = true
	spam_mult -= 0.2 if spam_mult >= 0.2 else 0.0
	if not stave_line.locked:
		stave_line.resolve(1 * spam_mult)

func _lock_note():
	locked = true
	await get_tree().create_timer(0.05).timeout
	locked = false

func _on_combo_timer_timeout() -> void:
	comboing = false

func _on_spam_timer_timeout() -> void:
	spam_mult = 1.2
