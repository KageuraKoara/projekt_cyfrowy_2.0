extends Node

var time_total : float
var chords_played : int
var accuracy

var input_left := "movement_Q"
var input_jump := "movement_Space"
var input_right := "movement_P"

func reset():
	time_total = 0.0
	chords_played = 0
	input_left = "movement_Q"
	input_jump = "movement_Space"
	input_right = "movement_P"
