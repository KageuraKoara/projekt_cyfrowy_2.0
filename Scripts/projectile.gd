extends CharacterBody2D

@export var speed = 100
@export var Direction : float

var Spawn_Position : Vector2
var Spawn_Rotation : float
var note := ""
var frame = 0
var time_damage = 0.5

var keys_posY = {
	"E": 500,
	"R": 460,
	"T": 420,
	"Y": 380,
	"U": 340,
	"I": 300,
	"O": 260,
}

func _ready() -> void:
	global_position = Spawn_Position
	global_rotation = Spawn_Rotation
	$AnimatedSprite2D.frame = frame
	
func _physics_process(delta: float) -> void:
	velocity = Vector2(speed,0).rotated(Direction)
	move_and_slide()
