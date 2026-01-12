extends CharacterBody2D

@onready var Main = get_tree().get_root().get_node("Level1")

var direction := 0.0
var vel_x := -200
var is_alive := true
var stave_line
var caught := false

func _ready() -> void:
	$AnimatedSprite2D.play("idle")
	stave_line = randi_range(0, 6)

func _physics_process(delta: float) -> void:
	if global_position.y != Main.keys_posY[stave_line]:
		var t = create_tween()
		t.tween_property(self, "global_position:y", Main.keys_posY[stave_line], 0.2)
	else:
		global_position.y = Main.keys_posY[stave_line]
	velocity.x = vel_x
	move_and_slide()
	
	if caught and global_position.x >= 700: despawn()

func go_back():
	caught = true
	vel_x = 200
	$AnimatedSprite2D.flip_h = true

func _on_detection_area_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		despawn()
	elif body.is_in_group("player"):
		Main._on_got_hit("ink_raven", 15.0)
		despawn()

func _on_despawn_timeout() -> void:
	despawn()

func despawn():
	is_alive = false
	queue_free()
