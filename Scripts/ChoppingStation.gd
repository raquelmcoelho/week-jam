extends StaticBody2D

var object_above_station = false
var station_full = false
var station_action = "chopping"
var offset_value = 60
var ingredient

func _process(_delta):
	$Filter.visible = object_above_station and not station_full

func do():
	pass

func done():
	self.station_full = true
	var sprite
	if ingredient.sprite_str == "ingredient_1":
		sprite = "yellow_food"
	elif ingredient.sprite_str == "ingredient_2":
		sprite = "green_food"
	else:
		sprite = "red_food"
	Main.spawn_food(self, sprite)
	$AnimatedSprite2D.play("idle")
	ingredient.queue_free()
	ingredient = null
