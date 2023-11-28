extends StaticBody2D

var object_above_station = false
var station_full = false
var station_action = "washing"
var offset_value = 60
var empty: bool = true
var plate
var offset_plate = -25 

func _process(_delta):
	$Filter.visible = object_above_station and not station_full

func do():
	$AudioStreamPlayer2D.play()
	pass

func done():
	$AudioStreamPlayer2D.stop()
	self.station_full = false
	self.empty = true
	Global.spawn_coins(self.position, get_parent())
	plate.queue_free()
	plate = null
	$AnimatedSprite2D.play("idle")
