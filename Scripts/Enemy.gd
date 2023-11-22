extends Area2D
class_name Enemy



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_Aread2D_body_entered(body):
	if body.get_name() == "Player":
		die()
		
func die():
	# emitir som de morte
	Main.coins += Main.bonus
	queue_free()
