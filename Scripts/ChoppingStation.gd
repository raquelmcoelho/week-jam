extends StaticBody2D

var player_above_station = false
var station_full = false
var station_action = "chopping"
var offset_value = 60

func _process(delta):
	$Filter.visible = player_above_station and not station_full
