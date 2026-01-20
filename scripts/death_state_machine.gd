extends Node2D

var current_state : State
var previous_state : State

var raven_charge_count := 0

func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	current_state = get_child(0) as State
	previous_state = current_state
	current_state.enter()

func change_state(state):
	current_state = find_child(state) as State
	current_state.enter()
	
	previous_state.exit()
	previous_state = current_state
