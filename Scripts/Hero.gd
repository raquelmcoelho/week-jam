extends CharacterBody2D

var speed = 350

var dragging: bool = false
var is_inside_dropable: bool = false
var on_station

func _ready():
	z_index = 1
	$AnimatedSprite2D.play("idle")
	
func get_input():
	if on_station:
		return
	velocity.x = Input.get_axis("ui_left", "ui_right") * speed
	velocity.y = Input.get_axis("ui_up", "ui_down") * speed
	if Input.is_action_just_pressed("action"):
		interact()

func _physics_process(_delta):
	if velocity.x != 0 or velocity.y != 0:
		$AnimatedSprite2D.set_speed_scale(2.5)
	else:
		$AnimatedSprite2D.set_speed_scale(1)
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	elif velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	get_input()
	move_and_slide()

func interact():
	velocity = Vector2(0,0)
	if get_last_slide_collision():
		var body = get_last_slide_collision().get_collider()
		if body.is_in_group('enemy'):
			body.die()
		elif body.is_in_group('station'):
			is_inside_dropable = true
			on_station = body

	if not is_inside_dropable:
		return
	elif on_station.station_full or on_station.empty:
		is_inside_dropable = false
		adjust_player(120, on_station)
		on_station = null
	else:
		if on_station.station_action == "cooking":
			self.z_index = -1
		on_station.do()
		on_station.station_full = true
		adjust_player(on_station.offset_value, on_station)
		$AnimatedSprite2D.play(on_station.station_action)
		$Progress.start_timer(self)
		$CollisionShape2D.disabled = true

func finish_station():
	adjust_player(120, on_station)
	on_station.station_full = false
	self.z_index = 1
	on_station.done()
	is_inside_dropable = false
	on_station = null
	$AnimatedSprite2D.play("idle")
	$CollisionShape2D.disabled = false

func adjust_player(offset_value, object):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(object.position.x, object.position.y - offset_value) , 0.2).set_ease(Tween.EASE_OUT)
