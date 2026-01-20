extends Node2D
class_name State

@onready var Main = get_tree().get_root().get_node("Level1")
@onready var pr_layer = owner.get_parent().find_child("ProjectileLayer")
@onready var player = owner.get_parent().find_child("Player")
@onready var wind_node = load("res://scenes/wind_gust.tscn")

@onready var debug = owner.find_child("debug")
@onready var animation_player = owner.find_child("AnimationPlayer")
@onready var attackCD_timer = owner.find_child("AttackCooldownTimer")
@onready var default_collision = $"../../DeathCollision/DefaultCollision"
@onready var raven_collision = $"../../DeathCollision/RavenCollision"
@onready var detection_collision = $"../../PlayerDetection/DetectionCollision"

var busy := false
var raven := false
var it_wimdy := false

func _ready() -> void:
	set_physics_process(false)

func enter():
	set_physics_process(true)

func exit():
	set_physics_process(false)

func transition():
	print(busy)
	pass

func _physics_process(delta: float) -> void:
	transition()
	debug.text = name

func is_busy(b : bool, time : float):
	busy = b
	owner.start_attackCD(time)

func is_raven(b : bool):
	raven = b

func spawn_wind():
	var wind = wind_node.instantiate()
	pr_layer.add_child(wind)
	it_wimdy = true
