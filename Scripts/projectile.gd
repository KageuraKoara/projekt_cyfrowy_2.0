extends CharacterBody2D

@export var speed = 100
@export var Direction : float

var PlayerX_Position
var Spawn_Rotation : float
var speed_multiplier : float
var note = null
var frame = 0
var HP = 0.5

var keys_posY = [500, 460, 420, 380, 340, 300, 260]

func _ready() -> void:
	global_position = Vector2(PlayerX_Position, keys_posY[note])
	global_rotation = Spawn_Rotation
	$AnimatedSprite2D.frame = frame
	
func _physics_process(delta: float) -> void:
	velocity = Vector2(speed,0).rotated(Direction)
	move_and_slide()

func _on_despawn_timeout() -> void:
	queue_free()
