extends CharacterBody2D

@onready var Main = get_tree().current_scene # get_tree().get_root().get_node("Level1")
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var GRAVITY := 800.0
@export var WALK_SPEED := 300
@export var DASH_SPEED := 600
@export var JUMP_FORCE := -500.0
@export var SUPER_JUMP_FORCE := -800.0

var Pre_jump = preload("res://sounds/Compositor/Attacks/Combo/Jump.ogg")
var Pre_dash = preload("res://sounds/Compositor/Attacks/Combo/Dash.ogg")

var left_input := SceneSharedData.input_left
var jump_input := SceneSharedData.input_jump
var right_input := SceneSharedData.input_right

enum PlayerState {
	IDLE,
	WALK,
	JUMP,
	FALL,
	ATTACK,
	DAMAGE
}

var state: PlayerState = PlayerState.IDLE
var speed := WALK_SPEED

func _ready() -> void:
	set_state(PlayerState.IDLE)

func _physics_process(delta):
	handle_gravity(delta)
	handle_movement()
	handle_jump()
	move_and_slide()
	update_state()

func handle_movement():
	var input := Input.get_axis(left_input, right_input)
	speed = DASH_SPEED if $DashTimer.time_left > 0 else WALK_SPEED
	velocity.x = input * speed

	'if input != 0:
		sprite.flip_h = input < 0'

func handle_jump():
	if Input.is_action_just_pressed(jump_input) and is_on_floor():
		velocity.y = SUPER_JUMP_FORCE if $SuperJumpTimer.time_left > 0 else JUMP_FORCE

func handle_gravity(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta

func update_state():
	if state == PlayerState.ATTACK or state == PlayerState.DAMAGE:
		return

	if not is_on_floor():
		if velocity.y < 0:
			set_state(PlayerState.JUMP)
		else:
			set_state(PlayerState.FALL)
	elif abs(velocity.x) > 0:
		set_state(PlayerState.WALK)
	else:
		set_state(PlayerState.IDLE)

func set_state(new_state: PlayerState):
	if state == new_state:
		return

	state = new_state

	match state:
		PlayerState.IDLE:
			play_anim("Idle")
		PlayerState.WALK:
			play_anim("Walking")
			$Walking.play()
		PlayerState.JUMP:
			play_anim("Jumping")
			$JumpSFX.play()
		PlayerState.FALL:
			play_anim("Falling")
			$JumpSFX.stop()
			$Fall.play()
		PlayerState.ATTACK:
			play_anim("Attack_" + str(randi_range(1, 2)))
		PlayerState.DAMAGE:
			play_anim("Damage_" + str(randi_range(1, 2)))
			$Damage.play()
func play_anim(anim_name: String):
	if animation_player.current_animation != anim_name:
		animation_player.play(anim_name)

func _on_collision_entered(body: Node2D) -> void:
	if body.is_in_group("projectile"):
		if body.winded:
			Main._on_got_hit(body.note, body.HP)
			body.despawn()

func death():
	animation_player.play("Dying")
	await animation_player.animation_finished
	get_tree().change_scene_to_file("res://Scenes/UI/Lost.tscn")

# -------- External Calls --------

func play_attack():
	set_state(PlayerState.ATTACK)
	await animation_player.animation_finished
	set_state(PlayerState.IDLE)

func _on_damage():
	set_state(PlayerState.DAMAGE)
	await animation_player.animation_finished
	set_state(PlayerState.IDLE)

func _on_knockback(push: float):
	if global_position.x >= -350:
		var t = create_tween()
		t.tween_property(self, "global_position:x", global_position.x - push, 0.2)
		await animation_player.animation_finished
		set_state(PlayerState.IDLE)

func StartDashTimer():
	$DashGlow.visible = true
	$DashTimer.start()
	$Jingle.play()
	$Combo.stream = Pre_jump
	$Combo.play()
func StartSJumpTimer():
	$SuperJumpGlow.visible = true
	$SuperJumpTimer.start()
	$Combo.stream = Pre_dash
	$Jingle.play()

func _on_dash_timeout() -> void:
	$DashGlow.visible = false

func _on_sjump_timeout() -> void:
	$SuperJumpGlow.visible = false

func note_boost_glow(b : bool):
	$NoteBoostGlow.visible = b
