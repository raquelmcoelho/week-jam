extends StaticBody2D
class_name Station

var player_above_station = false
var station_full = false
var station_action = "chopping"

func _process(delta):
	$Filter.visible = player_above_station and not station_full
