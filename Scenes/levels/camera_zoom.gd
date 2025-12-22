extends Camera2D
	
var size = get_viewport_rect()
	
func _process(delta: float) -> void:
	size = get_viewport_rect()
	#print(size)
	
