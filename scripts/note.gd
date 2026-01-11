extends AnimatedSprite2D

@export var input = ""
@export var comboTime = 0.1
@export var pitch: AudioStreamWAV

var comboing = false
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

func _on_combo_timer_timeout() -> void:
	comboing = false

func _on_spam_timer_timeout() -> void:
	spam_mult = 1.2
