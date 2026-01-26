extends CharacterBody2D

@onready var Main = get_tree().get_root().get_node("Level1")
@onready var Raven = get_tree().get_root().get_node("../Death/Raven")
@onready var Raven_death = get_tree().get_root().get_node("../Death/Death_raven")
@export var speed := 100
@export var Direction : float

var PlayerX_Position
var speed_multiplier : float
var note = null
var type := ""
var HP := 0.5
var pos_y
var caught := false
var damn_chicken
var winded := false

# odwrócenie kierunku lotu: Direction = -PI

func _ready() -> void:
	global_position = Vector2(PlayerX_Position, pos_y[note])
	speed = speed * speed_multiplier
	$AnimatedSprite2D.play(type)
	if speed < 100:
		despawn()
	
func _physics_process(delta: float) -> void:
	if not caught:
		velocity = Vector2(speed,0).rotated(Direction)
		move_and_slide()
	else:
		if is_instance_valid(damn_chicken):
			global_position = damn_chicken.global_position + Vector2(50, 0)
		else:
			despawn()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy_projectile"):
		if body.name == "ink_raven":
			despawn()
			damn_chicken = body
			if type != "single":
				body.despawn()
				get_debuffed(0.5)
			else:
				caught = true
				Raven_death.play()
				$Area2D/CollisionShape2D.set_deferred("disabled", true)
				$CollisionShape2D.set_deferred("disabled", true)
				
				body.go_back()
				Raven.stop()
				


func get_debuffed(percent : float):
	speed = speed * percent
	HP = HP * percent

func get_rotated_idiot():
	if type != "single":
		get_debuffed(0.5)
	else:
		winded = true
		Direction = -PI
		set_collision_mask_value(2, true)

func _on_despawn_timeout() -> void:
	despawn()

func despawn():
	speed = 0
	$AnimatedSprite2D.play(type + "_hit")
	await $AnimatedSprite2D.animation_finished
	queue_free()
