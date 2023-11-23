extends StaticBody2D

var object_above_station = false
var station_full = false
var station_action = "cooking"
var offset_value = 54
var offset_ingredient = -25
var ingredient

func _process(_delta):
	$Filter.visible = object_above_station and not station_full

func do():
	$AnimatedSprite2D.play(station_action)

func done():
	self.station_full = true
	var sprite
	if ingredient.sprite_str == "red_food":
		sprite = "soup"
	elif ingredient.sprite_str == "green_food":
		sprite = "sandwich"
	else:
		sprite = "pasta"
	Main.spawn_food(self, sprite)
	$AnimatedSprite2D.play("idle")
	ingredient.queue_free()
	ingredient = null
