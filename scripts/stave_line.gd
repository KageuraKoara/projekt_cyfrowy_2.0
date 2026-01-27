extends AnimatedSprite2D

@onready var Main = get_tree().current_scene # get_tree().get_root().get_node("Level1")
@onready var active_timer = $ActiveTimer 

@export var note : AnimatedSprite2D
@export var type := "" # line / space
@export var id := 0 # 0 - 12

var locked := true

func _ready() -> void:
	global_position.y = Main.keys_posY[id]
	assign_base()

func _process(delta: float) -> void:
	'if Main.song_position_in_beats == 10:
		assign_pre_gold([0, 2, 5])
	if Main.song_position_in_beats == 12:
		activate([0, 2, 5])'

func assign_base():
	play(type + "_base") if id != 0 else play("space_base")

func assign_pre_gold(ids : Array[int]):
	if ids.has(id):
		play(type + "_gold")
		set_deferred("self_modulate", Color(1, 1, 1, 0.5))

func activate(ids : Array[int]):
	if ids.has(id):
		# play(type + "_gold")
		set_deferred("self_modulate", Color(1, 1, 1, 1))
		locked = false
		active_timer.start()

func _on_active_timer_timeout() -> void:
	resolve(0.0)

func resolve(points : float):
	if not locked:
		assign_base()
		active_timer.stop()
		Main.acc_points += points
		locked = true


# kilka beatów przed włączeniem ActiveTimer włączyć animację podświetlania, a przy uruchomieniu timera włączyć wygląd "click now"
# jeśli zostało kliknięte podczas ActiveTimera, podłączona nuta wysyła tu jakiś sygnalik i wtedy linia (animacja) się wyłącza + nalicza punkciki
