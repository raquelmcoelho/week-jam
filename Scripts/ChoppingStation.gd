extends StaticBody2D

var object_above_station = false
var station_full = false
var station_action = "chopping"
var offset_value = 60
var offset_ingredient = -25
var ingredient
var empty: bool = true

func _process(_delta):
	$Filter.visible = object_above_station and not station_full

func do():
	$AudioStreamPlayer2D.play()

func done():
	$AudioStreamPlayer2D.stop()
	self.station_full = true
	self.empty = true
	var sprite
	if ingredient.sprite_str == "ingredient_soup":
		sprite = "food_soup"
	elif ingredient.sprite_str == "ingredient_pasta":
		sprite = "food_pasta"
	else:
		sprite = "food_sandwich"
	Main.spawn_food(self, sprite)
	$AnimatedSprite2D.play("idle")
	ingredient.queue_free()
	ingredient = null
