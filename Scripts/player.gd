extends CharacterBody2D

@onready var Main = get_tree().get_root().get_node("Level1")
@onready var Death = get_parent().find_child("Death")
@onready var animation_player = $AnimationPlayer

@export var Gravity: float = 800.0
@export var Jump_Velocity: float = -400.0
var Speed : int
var direction
var note_direction: float = 0.0

var is_falling: bool = false
var input_walking: float = 0.0
var input_jump: float = 0.0
var is_jumping: bool = false

func _ready() -> void:
	play_idle()

func play_idle():
	animation_player.play("Idle")

func play_walking():
	if velocity.x != 0.0 and self.is_on_floor():
		animation_player.play("Walking")
	else:
		play_idle()
	
	#_________ Movement handler _________#
	
func _physics_process(delta):
	move_and_slide()
	HandleGravity(self, delta)
	handle_jump(self, jump_input())
	play_walking()

func _process(_delta: float) -> void:
	direction = (Death.position - position).normalized()
	
	if direction.x < 0:
		$AnimatedSprite2D.flip_h = true
		note_direction = -3.12
	else:
		$AnimatedSprite2D.flip_h = false
		note_direction = 0.0
	
	if $DashTimer.time_left != 0:
		Speed = 600
	else:
		Speed = 300
	
	if $SuperJumpTimer.time_left != 0:
		Jump_Velocity = -600.0
	else:
		Jump_Velocity = -400.0
	
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
	
	if is_falling:
		animation_player.play("Falling")
	elif is_jumping:
		animation_player.play("Jumping")
	else:
		pass
	await animation_player.animation_finished

func StartDashTimer():
	$DashTimer.start()

func StartSJumpTimer():
	$SuperJumpTimer.start()

func _on_knockback(push):
	var t = create_tween()
	animation_player.play("Damage_", randi_range(1, 2))
	t.tween_property(self, "global_position:x", global_position.x - push, 0.2)
	await animation_player.animation_finished
	play_idle()

func play_attack():
	animation_player.play("Attack_1")
	await animation_player.animation_finished
	play_idle()
