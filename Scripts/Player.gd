extends Area2D
class_name Player

signal player_dropped(player)

var _dragging: bool = false

func _ready() -> void:
	$AnimatedSprite2D.play("cooking")

func _process(_delta: float) -> void:
	if _dragging:
		_attach_to_mouse()

func _attach_to_mouse():
	global_position = get_global_mouse_position()

func _on_Player_input_event(_viewport, _event, _shape_idx):
	# Mouse is over the game piece and left click was made
	if Input.is_action_just_pressed("click"):
		_dragging = true
	elif Input.is_action_just_released("click"):
		_dragging = false
		print("Emiting signal[game_piece_dropped]")
		emit_signal("player_dropped", self)
