extends Node

var coin_scene = load("res://Scenes/Coin.tscn")
var rat_scene = load("res://Scenes/Rat.tscn")
var food_scene = load("res://Scenes/Food.tscn")
var costumer_scene = load("res://Scenes/Costumer.tscn")
var bonus = 10
var coins = 0
var is_dragging = false

func _ready():
	spawn_clients()
	
func receiveMoney():
	pass

func spawnEnemy():
	pass
	
func spawn_food(station):
	var food = food_scene.instantiate()
	food.sprite_str = "pasta"
	food.on_station = station
	add_child(food)

func _on_enemy_timer_timeout():
	pass
	#spawnEnemy()
	
	
func spawn_clients():
	var line = []
	for i in range(5):
		print("cliente ", i)
		var costumer = costumer_scene.instantiate()
		costumer.position_in_line = i
		line.append(costumer)
		add_child(costumer)
