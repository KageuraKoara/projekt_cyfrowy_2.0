extends AnimatedSprite2D

@export var input = ""
@export var comboTime = 0.1
@export var pitch: AudioStreamWAV

var comboing = false

func _ready() -> void:
	$ComboTimer.wait_time = comboTime
	$NoteSound.stream = pitch

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action(input):
		if event.is_action_pressed(input, false):
			$NoteSound.play()
			$ComboTimer.start()
			comboing = true

func _on_combo_timer_timeout() -> void:
	comboing = false
