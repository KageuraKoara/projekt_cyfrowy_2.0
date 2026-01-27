extends TextureProgressBar

@onready var hp_indicator = preload("res://scenes/UI/hp_indicator.tscn")

@export var wait_time := 20.0

var second_accumulator := 20.0
var time_scale := 1.0
var once = true
var hp_ind_color = Color(1, 1, 1) # Color(0.933, 0.377, 0.497)

signal your_time_ran_out

func _physics_process(delta: float) -> void:
	if wait_time <= 0.0:
		time_scale = 0.0
		if once:
			emit_signal("your_time_ran_out")
			once = false
	
	var scaled_delta = delta * time_scale
	second_accumulator += scaled_delta
	wait_time -= scaled_delta
	
	while second_accumulator >= 1.0:
		second_accumulator -= 1.0
	
	$Label.text = str(ceil(wait_time))
	value = wait_time

func add_time(amount: float):
	SceneSharedData.time_total += amount
	
	if wait_time < max_value:
		wait_time += amount
	else:
		wait_time = max_value
	
	var hp_ind = hp_indicator.instantiate()
	hp_ind.symbol = "+ "
	hp_ind.value = amount
	hp_ind.pos_y = 400
	hp_ind.color = hp_ind_color
	add_child(hp_ind)

func remove_time(amount: float):
	SceneSharedData.time_total -= amount
	
	wait_time = max(wait_time - amount, 0)
	
	var hp_ind = hp_indicator.instantiate()
	hp_ind.symbol = "- "
	hp_ind.value = amount
	hp_ind.pos_y = 3200
	hp_ind.color = hp_ind_color
	add_child(hp_ind)
