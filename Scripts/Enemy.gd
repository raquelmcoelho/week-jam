extends Area2D
class_name Enemy


func _on_Aread2D_body_entered(body):
	if body.get_name() == "Player":
		die()
		
func die():
	# emitir som de morte
	Main.coins += Main.bonus
	queue_free()
