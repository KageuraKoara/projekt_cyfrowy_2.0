extends VSlider
@onready var bottom: VSlider = $"../Bottom"
@onready var top: VSlider = $"."
@onready var hourglass: Node2D = $Hourglass

func _on_value_changed(value: float) -> void:
	bottom.value = max_value - top.value
