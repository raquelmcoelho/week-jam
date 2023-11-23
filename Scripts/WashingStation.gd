extends StaticBody2D

var object_above_station = false
var station_full = false
var station_action = "washing"
var offset_value = 60
var empty: bool = true

func _process(_delta):
	$Filter.visible = object_above_station and not station_full

func do():
	$AudioStreamPlayer2D.play()
	pass

func done():
	$AudioStreamPlayer2D.stop()
	self.station_full = true
	$AnimatedSprite2D.play("idle")
	self.station_full = false
	self.empty = true
	var sprite = "dirty_dish"
	Main.spawn_coins()
	$AnimatedSprite2D.play("idle")
