extends Area2D

var run = false

func _ready():
	$AnimatedSprite2D.play("stop")

func _process(_delta):
	if run:
		$AnimatedSprite2D.play("run")
