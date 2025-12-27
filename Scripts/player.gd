extends CharacterBody2D

@onready var Main = get_tree().get_root().get_node("Level1")
@onready var Projectile = load("res://Scenes/Projectile.tscn")

@export var Gravity: float = 800.0
@export var Jump_Velocity: float = -400.0
var Speed : int

var is_falling: bool = false
var input_walking: float = 0.0
var input_jump: float = 0.0
var is_jumping: bool = false

func _ready() -> void:
	pass
	
	#_________ Movement handler _________#
	
func _physics_process(delta):
	move_and_slide()
	HandleGravity(self, delta)
	handle_jump(self, jump_input())

func _process(_delta: float) -> void:
	if $DashTimer.time_left != 0:
		Speed = 600
		print("dash active")
	else:
		Speed = 300
	
	input_walking = Input.get_axis("movement_Q", "movement_P")
	velocity.x = input_walking * Speed

func jump_input() -> bool:
	return Input.is_action_just_pressed("movement_Space")
	
func handle_jump(body: CharacterBody2D, want_to_jump: bool) -> void:
	if want_to_jump and body.is_on_floor():
		body.velocity.y = Jump_Velocity
		
	is_jumping = body.velocity.y < 0 and not body.is_on_floor()

	#_________ Gravity _________#
	
func HandleGravity (body: CharacterBody2D, delta: float) -> void:
	if not body.is_on_floor():
		body.velocity.y += Gravity * delta
	is_falling = body.velocity.y > 0 and not body.is_on_floor()

func StartDashTimer():
	$DashTimer.start()

	#_________ Shooting notes _________#

'func Notes(input):
	var instance = Projectile.instantiate()
	instance.Direction = rotation
	instance.Spawn_Position = Vector2(global_position.x,base + keys[input])
	instance.Spawn_Rotation = rotation
	Main.add_child(instance)'
