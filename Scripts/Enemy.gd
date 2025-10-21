extends CharacterBody2D
class_name Enemy

@onready var path_follow = get_parent()

var pre_progress
var speed = 300
var move_direction = 0

func _physics_process(delta):
	MovementLoop(delta)

func _process(_delta):
	AnimationLoop()

func MovementLoop(delta):
	var prepos = path_follow.get_global_position()
	var progress = path_follow.get_progress()
	if pre_progress == progress:
		queue_free()
	pre_progress = progress
	path_follow.set_progress(progress + speed * delta)
	var pos = path_follow.get_global_position()
	move_direction = (pos.angle_to_point(prepos) / 3.14) * 180

func AnimationLoop():
	var animation = "down"
	if move_direction < -135 or move_direction >= 135:
		animation = "right"
	elif move_direction < 135 and move_direction >= 45:
		animation = "up"
	elif move_direction < 45 and move_direction >= -45:
		animation = "left"
	elif move_direction < -45 and move_direction >= -135:
		animation = "down"
	$AnimatedSprite2D.play(animation)

func die():
	$sounds/Idle.stop()
	queue_free()
