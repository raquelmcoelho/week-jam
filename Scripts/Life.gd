extends Node2D


var is_alive = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("Idle")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func kill():
	$AnimatedSprite2D.play("Death")
	is_alive = false

