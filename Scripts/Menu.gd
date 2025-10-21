extends Control

func _ready():
	$Mango.get_node("AnimatedSprite2D").play("menu")

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")

func _on_instruction_pressed():
	get_tree().change_scene_to_file("res://Scenes/Guide.tscn")

func _on_credits_pressed():
	get_tree().change_scene_to_file("res://Scenes/Credits.tscn")

func _on_difficulty_pressed():
	Global.difficulty = !Global.difficulty
	if Global.difficulty:
		$Difficulty/Label.text = "Dificuldade:\nIntenso!"
	else:
		$Difficulty/Label.text = "Dificuldade:\nModerado"
