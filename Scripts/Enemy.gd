extends CharacterBody2D
class_name Enemy

@onready var motion = Vector2.ZERO

func _ready():
	$AnimatedSprite2D.play("front")
		
func _process(_delta):
	move_and_collide(motion)
	#pass

func die():
	# emitir som de morte
	Main.coins += Main.bonus
	#queue_free()
	if(motion == Vector2.ZERO):
		trace1()
	
func turn_up(value=1):
	move(0, -value)
	$AnimatedSprite2D.play("back")
	
func turn_down(value=1):
	$AnimatedSprite2D.play("front")
	move(0, value) 
	
func turn_right(value=1):
	$AnimatedSprite2D.play("side")
	$AnimatedSprite2D.flip_h = true
	move(value, 0)
	
func turn_left(value=1):
	$AnimatedSprite2D.play("side")
	$AnimatedSprite2D.flip_h = false
	move(-value, 0)
	
func move(x, y):
	# var tween = get_tree().create_tween()
	# tween.tween_property(self, "position", Vector2(self.position.x + x, self.position.y + y) , 0.2).set_ease(Tween.EASE_OUT)
	motion = Vector2(x, y)
	print("espera timeout")
	await get_tree().create_timer(1).timeout
	print("acabou timeout")
	motion = Vector2.ZERO

func trace1():
	await turn_right()
	await turn_down()
	
