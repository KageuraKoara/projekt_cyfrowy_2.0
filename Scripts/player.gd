extends CharacterBody2D

@onready var Main = get_tree().get_root().get_node("Level1")
@onready var Projectile = load("res://Scenes/Projectile.tscn")
@onready var AnimatedSprite =  $'AnimatedSprite2D'

@export var Speed = 500
@export var Gravity: float = 1000.0
@export var Jump_Velocity: float = -350.0


var offset = -40 # notes offset


var is_falling: bool = false
var input_walking: float = 0.0
var input_jump: float = 0.0
var is_jumping: bool = false
var base = 500 #Basic Y for notes
var keys = {
	"E": 0,
	"R": offset,
	"T": offset*2,
	"Y": offset*3,
	"U": offset*4,
	"I": offset*5,
	"O": offset*6,
}

func _ready() -> void:
	pass
	
	#_________ Movement handler _________#
	
func _physics_process(delta):
	move_and_slide()
	HandleGravity(self, delta)
	handle_jump(self, jump_input())

func _process(_delta: float) -> void:
	input_walking = Input.get_axis("movement_Q", "movement_P")
	velocity.x= input_walking * Speed
	if Input.is_action_pressed("movement_Q") or Input.is_action_pressed("movement_P"):
		AnimatedSprite.play("Walking")
	

func jump_input() -> bool:
	return Input.is_action_just_pressed("movement_Space")
	
func handle_jump(body: CharacterBody2D, want_to_jump: bool) -> void:
	if want_to_jump and body.is_on_floor():
		body.velocity.y = Jump_Velocity		
		
	is_jumping = body.velocity.y < 0 and not body.is_on_floor()
	AnimatedSprite.play("Jumping")
	
	if body.is_on_floor():
		AnimatedSprite.play("default")

	

	#_________ Gravity _________#
	
func HandleGravity (body: CharacterBody2D, delta: float) -> void:
	if not body.is_on_floor():
		body.velocity.y += Gravity * delta
	is_falling = body.velocity.y > 0 and not body.is_on_floor()

	#_________ Shooting notes _________#
	
func Notes(input):
	var instance = Projectile.instantiate()
	instance.Direction = rotation
	instance.Spawn_Position = Vector2(global_position.x,base + keys[input])
	instance.Spawn_Rotation = rotation
	Main.add_child(instance)
	
