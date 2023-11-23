extends CharacterBody2D

@export var speed = 400
var dragging: bool = false
var is_inside_dropable: bool = false
var station_ref
var on_station

func _ready():
	z_index = -1
	$AnimatedSprite2D.animation = "idle"
	
func get_input():
	if(Input.is_action_just_pressed("action")):
		interacts_with_stations()
	
	if(not on_station):
		velocity.x = Input.get_axis("ui_left", "ui_right") * speed
		velocity.y = Input.get_axis("ui_up", "ui_down") * speed

func _physics_process(_delta):
	get_input()
	move_and_slide()

func interacts_with_stations():
	if(get_last_slide_collision()):
		var body = get_last_slide_collision().get_collider()
		print(get_last_slide_collision().get_collider().name)
		
		if body.is_in_group('enemy'):
			print("rato")
			body.die()
		elif body.is_in_group('station'):
			is_inside_dropable = true
			body.object_above_station = true
			station_ref = body

	
	if not is_inside_dropable:
		$AnimatedSprite2D.play("idle")
		if on_station != null:
			on_station.station_full = false
			on_station = null
	elif station_ref.station_full and station_ref != on_station:
		adjust_player(200, station_ref)
	else:
		on_station = station_ref
		self.z_index = -1
		on_station.do()
		on_station.station_full = true
		on_station.object_above_station = false
		adjust_player(on_station.offset_value, on_station)
		$AnimatedSprite2D.play(on_station.station_action)
		$Progress.start_timer(self)
		$CollisionShape2D.disabled = true

func finish_station():
	adjust_player(150, station_ref)
	on_station.station_full = false
	self.z_index = 1
	on_station.done()
	is_inside_dropable = false
	on_station.object_above_station = false
	on_station = null
	$AnimatedSprite2D.play("idle")
	$CollisionShape2D.disabled = false
	

func adjust_player(offset_value, object):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(object.position.x, object.position.y - offset_value) , 0.2).set_ease(Tween.EASE_OUT)
	
