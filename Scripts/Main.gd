extends Node

var coin_scene = load("res://Scenes/Coin.tscn")
var rat_scene = load("res://Scenes/Rat.tscn")
var food_scene = load("res://Scenes/Food.tscn")
var bonus = 10
var coins = 0
var is_dragging = false

func receiveMoney():
	pass

func spawnEnemy():
	var rat = rat_scene.instantiate()
	add_child(rat)

func spawn_food(station):
	var food = food_scene.instantiate()
	food.sprite_str = "pasta"
	food.on_station = station
	add_child(food)

func _on_enemy_timer_timeout():
	pass
	#spawnEnemy()
