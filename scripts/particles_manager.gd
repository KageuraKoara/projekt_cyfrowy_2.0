extends Node2D

func splash():
	$Splash.visible = true
	$Splash.emitting = true

func wind():
	$Wind.emitting = true
	# $Wind2.emitting = true
	$Feathers.emitting = true

func stop_wimdy():
	$Wind.emitting = false
	# $Wind2.emitting = false
	$Feathers.emitting = false
