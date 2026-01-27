extends CharacterBody2D

@onready var Main = get_tree().get_root().get_node("Level1")

var direction := 0.0
var vel_y := 500

func _ready() -> void:
	global_position.x = randi_range(-500, 1200)
	global_position.y = -200

func _physics_process(delta: float) -> void:
	velocity.y = vel_y
	move_and_slide()
	
	if is_on_floor(): despawn()

func _on_detection_area_entered(body: Node2D) -> void:
	if body.is_in_group("projectile"):
		body.get_debuffed(0.7)
		despawn()
	elif body.is_in_group("player"):
		Main._on_got_hit("ink_droplet", 5.0)
		despawn()

func _on_despawn_timeout() -> void:
	despawn()

func despawn():
	$CollisionShape2D.disabled = true
	$DetectionArea/CollisionShape2D.disabled = true
	$Particles.splash()
	$InkDrop.visible = false
	await get_tree().create_timer(1).timeout
	queue_free()
