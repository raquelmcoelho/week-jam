extends Area2D
class_name Player

var dragging: bool = false
var is_inside_dropable: bool = false
var station_ref
var on_station
var forbidden

func _ready() -> void:
	z_index = 1
	$AnimatedSprite2D.play("idle")

func _process(_delta: float) -> void:
	if dragging:
		follow_mouse()

func follow_mouse():
	global_position = get_global_mouse_position()

func _on_Player_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("click"):
		if not Main.is_dragging:
			Main.is_dragging = true
			dragging = true
	elif Input.is_action_just_released("click"):
		Main.is_dragging = false
		dragging = false
		dropped()

func dropped():
	if not is_inside_dropable:
		$AnimatedSprite2D.play("idle")
		if on_station != null:
			on_station.station_full = false
			on_station = null
	elif (station_ref.station_full and station_ref != on_station) or station_ref.empty:
		adjust_position(150, station_ref)
	else:
		on_station = station_ref
		if on_station.station_action == "cooking":
			self.z_index = -1
		on_station.do()
		on_station.station_full = true
		on_station.object_above_station = false
		adjust_position(on_station.offset_value, on_station)
		$AnimatedSprite2D.play(on_station.station_action)
		$Progress.start_timer(self)
		$CollisionShape2D.disabled = true
	if forbidden:
		adjust_position(-90, forbidden)

func finish_station():
	adjust_position(120, station_ref)
	on_station.station_full = false
	self.z_index = 1
	on_station.done()
	on_station = null
	$AnimatedSprite2D.play("idle")
	$CollisionShape2D.disabled = false
	
func adjust_position(offset_value, object):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(object.position.x, object.position.y - offset_value) , 0.2).set_ease(Tween.EASE_OUT)
	
func _on_body_entered(body):
	if body.is_in_group('enemy'):
		Main.spawn_coins(body.get_position_delta())
		body.die()
	elif body.is_in_group('station'):
		is_inside_dropable = true
		body.object_above_station = true
		station_ref = body

func _on_body_exited(body):
	if body.is_in_group('station'):
		is_inside_dropable = false
		body.object_above_station = false

func _on_mouse_entered():
	if not Main.is_dragging:
		scale = Vector2(2.1, 2.1)

func _on_mouse_exited():
	if not Main.is_dragging:
		scale = Vector2(2, 2)
