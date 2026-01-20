extends CharacterBody2D

@onready var Main = get_tree().get_root().get_node("Level1")

@export var speed := 100
@export var Direction : float

var PlayerX_Position
var speed_multiplier : float
var note = null
var type := ""
var frame := 0
var HP := 0.5
var pos_y
var caught := false
var damn_chicken
var winded := false

# odwrócenie kierunku lotu: Direction = -PI

func _ready() -> void:
	global_position = Vector2(PlayerX_Position, pos_y[note])
	speed = speed * speed_multiplier
	$AnimatedSprite2D.frame = frame
	if speed < 100:
		despawn()
	
func _physics_process(delta: float) -> void:
	if not caught:
		velocity = Vector2(speed,0).rotated(Direction)
		move_and_slide()
	else:
		if damn_chicken.is_alive:
			global_position = damn_chicken.global_position + Vector2(50, 0)
		else:
			despawn()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy_projectile"):
		if body.name == "ink_raven":
			damn_chicken = body
			if type != "single":
				body.despawn()
				get_debuffed(0.5)
			else:
				caught = true
				$Area2D/CollisionShape2D.set_deferred("disabled", true)
				$CollisionShape2D.set_deferred("disabled", true)
				body.go_back()

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
	queue_free()
