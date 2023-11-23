extends Area2D
class_name Food

var sprite_str
var dragging: bool = false
var is_inside_dropable: bool = false
var is_at_trash: bool = false
var station_ref
var on_station

func _ready():
	self.z_index = 1
	$AnimatedSprite2D.play(sprite_str)
	if "ingredient".is_subsequence_of(sprite_str):
		dragging = true

func _process(_delta: float) -> void:
	if dragging:
		follow_mouse()

func follow_mouse():
	global_position = get_global_mouse_position()

func _on_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("click"):
		if not Main.is_dragging:
			Main.is_dragging = true
			dragging = true
	elif Input.is_action_just_released("click"):
		Main.is_dragging = false
		dragging = false
		dropped()

func dropped():
	if is_inside_dropable and station_ref:
		if not station_ref.empty:
			adjust_position(150, station_ref)
		elif "food".is_subsequence_of(sprite_str) and station_ref.station_action == "cooking":
			attach_station()
		elif "ingredient".is_subsequence_of(sprite_str) and station_ref.station_action == "chopping":
			attach_station()
		else:
			adjust_position(150, station_ref)

	if on_station != null:
		on_station.station_full = false
		on_station.object_above_station = false
		on_station = null
		station_ref = null
		
	if is_at_trash:
		queue_free()
		

func attach_station():
	station_ref.ingredient = self
	station_ref.empty = false
	adjust_position(station_ref.offset_ingredient, station_ref)
	$CollisionShape2D.disabled = true

func adjust_position(offset_value, object):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(object.position.x, object.position.y - offset_value) , 0.2).set_ease(Tween.EASE_OUT)

func _on_body_entered(body):
	if body.name == "Trash":
		is_at_trash = true
	elif body.is_in_group('station'):
		is_inside_dropable = true
		body.object_above_station = true
		station_ref = body

func _on_body_exited(body):
	if body.is_in_group('station'):
		is_inside_dropable = false
		body.object_above_station = false
	if body.name == "Trash":
		is_at_trash = false

func _on_mouse_entered():
	if not Main.is_dragging:
		scale = Vector2(2.1, 2.1)

func _on_mouse_exited():
	if not Main.is_dragging:
		scale = Vector2(2, 2)
