extends Node2D

@export var wait_time := 20.0

var second_accumulator := 20.0
var time_scale := 1.0
var once = true

signal time_ran_out

func _physics_process(delta: float) -> void:
	if wait_time <= 0.0:
		time_scale = 0.0
		if once:
			emit_signal("time_ran_out")
			once = false
	
	var scaled_delta = delta * time_scale
	second_accumulator += scaled_delta
	wait_time -= scaled_delta
	
	while second_accumulator >= 1.0:
		second_accumulator -= 1.0
	
	$Label.text = str(ceil(wait_time))

func add_time(amount: float):
	wait_time += amount

func remove_time(amount: float):
	wait_time = max(wait_time - amount, 0)
