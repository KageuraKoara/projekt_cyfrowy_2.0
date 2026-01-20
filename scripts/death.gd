extends CharacterBody2D

@onready var Main = get_tree().get_root().get_node("Level1")
@onready var pr_layer = get_tree().get_root().get_node("Level1/ProjectileLayer")
@onready var player = get_parent().find_child("Player")
@onready var ink_droplet_node = load("res://scenes/ink_droplet.tscn")
@onready var animated_sprite = $AnimatedSprite2D
@onready var attackCD_timer = $AttackCooldownTimer

@export var min_attackCD := 2
@export var max_attackCD := 6

var direction : Vector2
var player_in_range := false
var default_position := Vector2(1200, 440)

signal death_hit(note: String, HP: float)

func _ready() -> void:
	global_position = default_position
	set_physics_process(false)

func _process(delta: float) -> void:
	direction = player.position - position
	
	if direction.x > 0:
		animated_sprite.flip_h = true
	else:
		animated_sprite.flip_h = false

func _physics_process(delta: float) -> void:
	velocity = direction.normalized() * 80
	move_and_collide(velocity * delta)

func _on_owie(note: float, HP: float) -> void:
	var mod_HP = HP * 1.2 if $StateMachine/Idle.raven else HP
	emit_signal("death_hit", note, mod_HP)

func hitting(attack_type : String, HP : float):
	if player_in_range:
		Main._on_got_hit(attack_type, HP)

func knockback(push : int):
	if player_in_range:
		player._on_knockback(push)

func _on_player_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true

func _on_player_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false

func start_attackCD(time):
	var CDtime = time if time > 0.0 else randi_range(min_attackCD, max_attackCD)
	attackCD_timer.start(CDtime)

func start_rain_timer():
	$SpecialAttackDurationTimer.start(10)
	spawn_ink_rain()

func spawn_ink_rain():
	if not $SpecialAttackDurationTimer.is_stopped():
		var ink_droplet = ink_droplet_node.instantiate()
		pr_layer.add_child(ink_droplet)
		await get_tree().create_timer(randf_range(0.5, 1.5)).timeout
		spawn_ink_rain()
