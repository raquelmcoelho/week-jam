extends StaticBody2D

var object_above_station = false
var station_full = false
var station_action = "cooking"
var offset_value = 54
var offset_ingredient = -25
var ingredient
var empty: bool = true

func _process(_delta):
	$Filter.visible = object_above_station and not station_full

func do():
	$AnimatedSprite2D.play(station_action)

func done():
	self.station_full = true
	self.empty = true
	var sprite
	if ingredient.sprite_str == "food_soup":
		sprite = "soup"
	elif ingredient.sprite_str == "food_pasta":
		sprite = "pasta"
	else:
		sprite = "sandwich"
	Main.spawn_food(self, sprite)
	$AnimatedSprite2D.play("idle")
	ingredient.queue_free()
	ingredient = null
