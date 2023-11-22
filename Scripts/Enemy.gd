extends StaticBody2D
class_name Enemy

func _ready():
	$AnimatedSprite2D.play("front")

func _process(_delta):
	$AnimatedSprite2D.play("side")
		
func die():
	# emitir som de morte
	Main.coins += Main.bonus
	queue_free()

func _on_body_entered(body):
	print("entrou")
	print(body.get_name())
	if body.get_name() == "Player":
		die()
