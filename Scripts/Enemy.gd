extends CharacterBody2D
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
	move_and_collide(Vector2(0, 1)) 

func trace1():
	motion.x = 700
	#move_and_slide(motion, Vector2.UP)
	
	
#func _physics_process(delta):
#	move_and_collide(Vector2(0, 1)) 
