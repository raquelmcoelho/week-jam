extends Control

func _ready():
	pass # Replace with function body.

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")

func _on_leave_pressed():
	get_tree().quit()

func _on_instruction_pressed():
	get_tree().change_scene_to_file("res://Scenes/Guide.tscn")
