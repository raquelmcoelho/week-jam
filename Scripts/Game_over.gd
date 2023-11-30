extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	if(Global.coins > Global.record):
		Global.record =  Global.coins
	Global.coins = 0
	$Record.text = "record: " + str(Global.record)
	


func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")

func _on_leave_pressed():
	get_tree().quit()
