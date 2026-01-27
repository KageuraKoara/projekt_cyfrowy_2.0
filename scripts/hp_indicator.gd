extends Label

var symbol
var value
var pos_y
var color

func _ready() -> void:
	add_theme_color_override("font_color", color)
	add_theme_color_override("font_outline_color", color)
	position = Vector2(3000, 1800)
	text = str(str(symbol) + str(value) + " HP")
	var t = create_tween()
	t.tween_property(self, "position:y", pos_y, 0.2)
	await get_tree().create_timer(0.3).timeout
	queue_free()
