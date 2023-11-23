extends Area2D
class_name Progress

func _ready():
	self.visible = false

func start_timer():
	self.visible = true
	$Timer.start()
	$AnimatedSprite2D.play("run")

func _on_timer_timeout():
	self.visible = false
