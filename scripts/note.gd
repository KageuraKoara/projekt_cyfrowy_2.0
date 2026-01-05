extends AnimatedSprite2D

@export var input = ""
@export var comboTime = 0.1
@export var pitch: AudioStreamWAV

var comboing = false

func _ready() -> void:
	$ComboTimer.wait_time = comboTime
	$NoteSound.stream = pitch

func get_played_idiot(input):
	$NoteSound.play()
	$ComboTimer.start()
	comboing = true

func _on_combo_timer_timeout() -> void:
	comboing = false
