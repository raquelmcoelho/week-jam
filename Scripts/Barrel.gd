extends Area2D

var sprite_str
var is_inside_dropable: bool = false
var station_ref
var on_station

func _ready():
	self.z_index = 1
	$AnimatedSprite2D.play(sprite_str)

func _on_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("click"):
		pass
	elif Input.is_action_just_released("click"):
		pass

func dropped():
	if is_inside_dropable:
		if station_ref.ingredient:
			pass
		elif "food".is_subsequence_of(sprite_str) and station_ref.station_action == "cooking":
			station_ref.ingredient = self
			$CollisionShape2D.disabled = true

	if on_station != null:
		on_station.station_full = false
		on_station.object_above_station = false
		on_station = null
		station_ref = null

func _on_mouse_entered():
	if not Main.is_dragging:
		scale = Vector2(2.1, 2.1)

func _on_mouse_exited():
	if not Main.is_dragging:
		scale = Vector2(2, 2)
