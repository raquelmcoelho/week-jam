extends Node

var coin_scene = load("res://Scenes/Coin.tscn")
var rat_scene = load("res://Scenes/Rat.tscn")
var food_scene = load("res://Scenes/Food.tscn")
var costumer_scene = load("res://Scenes/Costumer.tscn")
var barrel_scene = load("res://Scenes/Barrel.tscn")

var bonus = 10
var coins = 0
var is_dragging = false

func receive_money():
	pass

func spawn_enemy():
	var rat = rat_scene.instantiate()
	add_child(rat)

func spawn_food(station, sprite):
	var food = food_scene.instantiate()
	food.sprite_str = sprite
	food.position.x = station.position.x + 47
	food.position.y = station.position.y - 30
	food.on_station = station
	add_child(food)

func spawn_ingredient(sprite, position):
	var food = food_scene.instantiate()
	food.sprite_str = sprite
	food.position = position
	add_child(food)

func spawn_barrel(sprite, position):
	var barrel = barrel_scene.instantiate()
	barrel.sprite_str = sprite
	barrel.position = position
	add_child(barrel)

func spawn_clients():
	var line = []
	for i in range(5):
		print("cliente ", i)
		var costumer = costumer_scene.instantiate()
		costumer.position_in_line = i
		line.append(costumer)
		add_child(costumer)

func _on_enemy_timer_timeout():
	pass
	#spawn_enemy()

func _on_creation_timer_timeout():
	spawn_clients()
	spawn_barrel("pasta", Vector2(50,30))
	spawn_barrel("sandwich", Vector2(120,30))
	spawn_barrel("soup", Vector2(190,30))

