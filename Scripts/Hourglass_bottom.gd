extends VSlider
@onready var top: VSlider = $"../Top"
@onready var bottom: VSlider = $"."
@onready var hourglass: Node2D = $Hourglass

func _on_value_changed(value: float) -> void:
	top.value = max_value - bottom.value 
