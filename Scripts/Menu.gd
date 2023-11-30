extends Control

func _ready():
	$Mango.get_node("AnimatedSprite2D").play("menu")

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")

func _on_leave_pressed():
	get_tree().quit()

func _on_instruction_pressed():
	get_tree().change_scene_to_file("res://Scenes/Guide.tscn")
