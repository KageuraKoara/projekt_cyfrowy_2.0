extends TextureProgressBar


func cd_start():
	value = 0.0
	while value < max_value:
		await get_tree().create_timer(1.0).timeout
		value += 1.0
