extends Area2D
class_name Player

var _dragging: bool = false
var type: String: set = set_type

signal game_piece_dropped(piece)

func _ready() -> void:
	# Need to be above game board (at z=0)
	z_index = 1


func _process(_delta: float) -> void:
	if _dragging:
		_attach_to_mouse()


func get_texture():
	return $Sprite2D.texture


func set_type(x_or_o: String):
	type = x_or_o.to_lower()
	$Sprite2D.texture = load("res://Assets/Sprites/Mango/Idle/chef_idle-0.png")


func _attach_to_mouse():
	print("Attached to mouse")
	global_position = get_global_mouse_position()

func _on_Player_input_event(_viewport, _event, _shape_idx):
	# Mouse is over the game piece and left click was made
	if Input.is_action_just_pressed("click"):
		print("Recived signal[input_event] Input action was 'click' pressed")
		_dragging = true
	elif Input.is_action_just_released("click"):
		print("Recived signal[input_event] Input action was 'click' released")
		_dragging = false
		print("Emiting signal[game_piece_dropped]")
		emit_signal("game_piece_dropped", self)
