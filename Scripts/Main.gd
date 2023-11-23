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
	var instance = rat_scene.instantiate()
	add_child(instance)

func spawn_food(station):
	var food = food_scene.instantiate()
	food.sprite_str = "pasta"
	food.on_station = station
	add_child(food)

# timer randomico pra quando aparecer (máx 3 sec variância)
# spawn lugar aleatório quando timer for triggado (min 10 sec intervalo)
# fica som de rato
# 3 rotas fixas
# se houver colisão rato muda pra som de morte e some
# personagem respawna pro início
