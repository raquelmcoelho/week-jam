extends Area2D
class_name Progress

var current_player = null

func _ready():
	self.visible = false

func start_timer(player):
	self.visible = true
	$Timer.start()
	$AnimatedSprite2D.set_frame(0)
	$AnimatedSprite2D.play("run")
	current_player = player

func _on_timer_timeout():
	self.visible = false
	current_player.finish_station()
