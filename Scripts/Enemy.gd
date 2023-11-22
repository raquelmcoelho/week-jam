extends StaticBody2D
class_name Enemy


var motion = Vector2.ZERO

func _ready():
	$AnimatedSprite2D.play("front")

func _process(_delta):
	$AnimatedSprite2D.play("side")
		
func die():
	# emitir som de morte
	Main.coins += Main.bonus
	#queue_free()
	trace1()

func trace1():
	motion.x = 700
	#move_and_slide(motion, Vector2.UP)
	
