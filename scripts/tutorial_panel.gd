extends Control

var current_panel := 0

func _process(delta: float) -> void:
	$info/previous.visible = false if current_panel == 0 else true
	$info/next.visible = false if current_panel == 8 else true

func update_tutorial_text():
	match current_panel:
		0: $info/text.text = "Welcome. This is your practice stage."
		1: $info/text.text = "In “Decomposer”, music is your main weapon. Every NOTE you play grants you time as hourglass points (HP), but be careful - they are constantly decreasing, and any opponent you face will reap it away from you as well.\n \n In order to succeed in a stage, survive until the end of the composition. Don’t let your HP drop to zero."
		2: $info/text.text = "Press A/D or Q/P to move left/right. \n You can change your keybinds in the settings"
		3: $info/text.text = "Press SPACE or W to jump. \n You can change your keybinds in the settings"
		4: $info/text.text = "To play notes, press keys on your keyboard from the range of keys \n [ E R T Y U I O ] \n Each note represent a real note from the musical scale, represented also by the projectile’s height"
		5: $info/text.text = "You can combine the notes you play to form INTERVALS by pressing two keys simultaneously. Depending on the distance between two keys, the power of your attack will scale."
		6: $info/text.text = "CHORDS represent your most special abilities. Simultaneously pressing three keys distanced by one from each other will grant you a special effect - increased movement speed, a higher jump or increased speed and effectiveness of notes. They have a cooldown mark in the top right corner. \n \n Any three keys pressed will not become a chord - it has to be a specific configuration."
		7: $info/text.text = "Repeatedly using the same note configurations will give you a penalty and the effect of your attack will lessen. \n Keep your key pattern varied to avoid this."
		8: $info/text.text = "This stage gives you free space to familiarise yourself with the controls without the pressure of a fight."

func _on_previous_button_up() -> void:
	current_panel -= 1
	update_tutorial_text()

func _on_next_button_up() -> void:
	current_panel += 1
	update_tutorial_text()
