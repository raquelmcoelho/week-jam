extends StaticBody2D

var object_above_station = false
var station_full = false
var station_action = "chopping"
var offset_value = 60

func _process(_delta):
	$Filter.visible = object_above_station and not station_full

func do():
	$AnimatedSprite2D.play(station_action)

func done():
	self.station_full = true
	Main.spawn_food(self) # todo: change to ingredients
	$AnimatedSprite2D.play("idle")
