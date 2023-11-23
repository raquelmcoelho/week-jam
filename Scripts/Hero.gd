extends CharacterBody2D

@export var speed = 400
@export var rotation_speed = 1.5

var rotation_direction = 0

func _ready():
	$AnimatedSprite2D.animation = "idle"
	
func get_input():
	velocity.x = Input.get_axis("ui_left", "ui_right") * speed
	velocity.y = Input.get_axis("ui_up", "ui_down") * speed

func _physics_process(delta):
	get_input()
	rotation += rotation_direction * rotation_speed * delta
	move_and_slide()
