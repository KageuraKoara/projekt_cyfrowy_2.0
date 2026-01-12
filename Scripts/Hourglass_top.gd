extends VSlider
@onready var hourglass: Node2D = $Hourglass
@onready var bottom: VSlider = $"../Bottom"
@onready var top: VSlider = $"."

func _on_value_changed(value: float) -> void:
	bottom.value = max_value - top.value
