extends CharacterBody2D

@onready var path_follow = get_parent()

var pre_progress
var speed = 350
var move_direction = 0

func _ready():
	$AnimatedSprite2D.play("menu")

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
	$AnimatedSprite2D.flip_h = move_direction < 0
