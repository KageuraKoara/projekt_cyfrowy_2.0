extends CharacterBody2D

@onready var Main = get_tree().get_root().get_node("Level1")
@onready var Raven = get_tree().get_root().get_node("Level1/Death/Raven")
@onready var Raven_death = get_tree().get_root().get_node("Level1/Death/Death_raven")
@export var speed := 100
@export var Direction : float

var PlayerX_Position
var speed_multiplier : float
var note = null
var type := ""
var HP := 0.5
var pos_y
var winded := false

# odwrócenie kierunku lotu: Direction = -PI

func _ready() -> void:
	global_position = Vector2(PlayerX_Position, pos_y[note])
	speed = speed * speed_multiplier
	$AnimatedSprite2D.play(type)
	if speed < 100: # or velocity !!!!!!!
		queue_free()
	
func _physics_process(delta: float) -> void:
	velocity = Vector2(speed,0).rotated(Direction)
	move_and_slide()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy_projectile") and body.name == "ink_raven":
		match type:
			"single": queue_free()
			_: get_debuffed(0.5)

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
