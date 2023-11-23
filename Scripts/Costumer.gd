extends CharacterBody2D

var customer_position
var order = ""
var options = ["pasta", "sandwich", "soup"]
var skins = ["cartola", "laco", "paulin", "bone", "bigodon"]

func _ready():
	$AnimatedSprite2D.play(skins[randi_range(0,4)])
	order = options[randi_range(0,2)]
	ajust_position(customer_position)

func ajust_position(new_position):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", new_position, 2).set_ease(Tween.EASE_OUT)
