extends CharacterBody2D

var i: int = 0
var flip: bool = false

func _ready():
	$AnimatedSprite2D.play("menu")

func _process(_delta):
	i += 1
	if i >= 15:
		flip = !flip
		$AnimatedSprite2D.flip_h = flip
		i = 0
