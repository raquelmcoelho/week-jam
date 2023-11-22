extends Area2D
class_name Enemy



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# timer randomico pra quando aparecer (máx 3 sec variância)
# spawn lugar aleatório quando timer for triggado (min 10 sec intervalo)
# fica som de rato
# 3 rotas fixas
# se houver colisão rato muda pra som de morte e some
# personagem respawna pro início
