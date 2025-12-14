extends AnimatedSprite2D

@export var input = ""
@export var comboTime = 0.1

var comboing = false

func _ready() -> void:
	$ComboTimer.wait_time = comboTime

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action(input):
		if event.is_action_pressed(input, false):
			$ComboTimer.start()
			comboing = true

func _on_combo_timer_timeout() -> void:
	comboing = false
