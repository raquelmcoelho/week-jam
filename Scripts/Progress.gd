extends Area2D
class_name Progress

var run = false
var timer = Timer.new()

func _ready():
	$AnimatedSprite2D.play("stop")
	#timer.connect("timeout",self,"delete")
	timer.wait_time = 6
	timer.one_shot = true
	add_child(timer)
	timer.start()

func _process(_delta):
	if run:
		$AnimatedSprite2D.play("run")

func delete():
	queue_free()
