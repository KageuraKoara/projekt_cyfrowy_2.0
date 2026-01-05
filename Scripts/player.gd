extends CharacterBody2D

@onready var Main = get_tree().get_root().get_node("Level1")
@onready var Projectile = load("res://Scenes/Projectile.tscn")
@onready var AnimatedSprite =  $'AnimatedSprite2D'
@onready var Note: AnimatedSprite2D = $AnimatedSprite2D

@export var Speed = 500
@export var Gravity: float = 1000.0
@export var Jump_Velocity: float = -350.0

####State_Machine####
var state: String = "default"
var Movement: bool = false
var is_shooting: bool = false
var is_walking: bool = false
var is_falling: bool = false
var is_jumping: bool = false
var Full_animation_play :bool = false

####Inputs###
var input_walking: float = 0.0
var input_jump: float = 0.0

##Projectile-related###
var offset = -40 # notes offset
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
	Animations()


func _process(_delta: float) -> void:
	input_walking = Input.get_axis("movement_Q", "movement_P")
	velocity.x= input_walking * Speed
	
	#_________ State Machine _________#

func Animations():
	if !Movement:
		match state:
			"default":
				if input_walking != 0 && is_on_floor(): state = "Walking"
				if Note.animation.begins_with("1"): state = "Atak_2" ##It's broken, need fixing
				elif !is_on_floor(): state = "Jumping"


				AnimatedSprite.play(state)

			"Walking":
				if input_walking == 0: state = "default"
				elif !is_on_floor(): state = "Jumping"

				AnimatedSprite.play(state)

			"Jumping":
				if is_on_floor(): state = "default"
				elif input_walking != 0 && is_on_floor(): state = "Walking"

				AnimatedSprite.play(state)

			#Part below is also broken#
			"Atak_2":
				if Note.animation.begins_with("1") : state = "Atak_2"
				elif Note.animation.begins_with("0") : state = "Atak_1"

				AnimatedSprite.play(state)

			"Atak_1":
				if Note.animation.begins_with("0") : state = "Atak_1"
				if Note.animation.begins_with("1") : state = "Atak_2"
				elif Full_animation_play == false : Full_animation_play = true

				AnimatedSprite.play(state)

			_:
				print("undefined state: ", state)
				state = "default"

func _on_animated_sprite_2d_animation_finished() -> void:
	Full_animation_play = false
	state = "default"


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

	#_________ Shooting notes _________#
	
func Notes(input):
	var instance = Projectile.instantiate()
	is_shooting = true
	instance.Direction = rotation
	instance.Spawn_Position = Vector2(global_position.x,base + keys[input])
	instance.Spawn_Rotation = rotation
	Main.add_child(instance)
