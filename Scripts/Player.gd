extends Area2D
class_name Player

var dragging: bool = false
var is_inside_dropable: bool = false
var station_ref
var on_station

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

		if not is_inside_dropable:
			$AnimatedSprite2D.play("idle")
			if on_station != null:
				on_station.station_full = false
				on_station = null
		elif station_ref.station_full and station_ref != on_station:
			var tween = get_tree().create_tween()
			tween.tween_property(self, "position", Vector2(station_ref.position.x, station_ref.position.y-200) , 0.2).set_ease(Tween.EASE_OUT)
		else:
			on_station = station_ref
			on_station.station_full = true
			on_station.player_above_station = false
			var tween = get_tree().create_tween()
			tween.tween_property(self, "position", Vector2(on_station.position.x, on_station.position.y - on_station.offset_value) , 0.2).set_ease(Tween.EASE_OUT)
			$AnimatedSprite2D.play(on_station.station_action)
			$Progress.run = true

func _on_body_entered(body: StaticBody2D):
	if body.is_in_group('station'):
		is_inside_dropable = true
		body.player_above_station = true
		station_ref = body

func _on_body_exited(body):
	if body.is_in_group('station'):
		is_inside_dropable = false
		body.player_above_station = false

func _on_mouse_entered():
	if not Main.is_dragging:
		scale = Vector2(2.1, 2.1)

func _on_mouse_exited():
	if not Main.is_dragging:
		scale = Vector2(2, 2)
