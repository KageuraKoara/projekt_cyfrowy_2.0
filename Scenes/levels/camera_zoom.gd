extends Camera2D

@onready var wall_right: CollisionShape2D = $"./StaticBody2D/Wall_Right"
@onready var wall_left: CollisionShape2D = $"./StaticBody2D/Wall_Left"



var Left = wall_left
var Right = wall_right
@export var Max = 1.0
@export var Min = 0.5
	

func distance():
	
	Camera2D.zoom <= Max
	Camera2D.zoom >= Min
	
	
