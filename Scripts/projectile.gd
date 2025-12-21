extends CharacterBody2D

@export var speed = 100
@export var Direction : float

var Spawn_Position : Vector2
var Spawn_Rotation : float

func _ready() -> void:
	global_position = Spawn_Position
	global_rotation = Spawn_Rotation
	
func _physics_process(delta: float) -> void:
	velocity = Vector2(speed,0).rotated(Direction)
	move_and_slide()
