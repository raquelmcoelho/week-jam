extends Node
class_name Globals

var coin_scene : PackedScene = preload("res://Scenes/Coin.tscn")
var food_scene : PackedScene = preload("res://Scenes/Food.tscn")
var plate_scene : PackedScene = preload("res://Scenes/Plate.tscn")

var is_dragging = false
var record = 0
var coins = 0
var bonus = 10
var coins_animation = []


func _ready():
	create_coins()
	
func create_coins():
	coins_animation = []
	print("creating coins id: ", self)
	for i in range(3):
		var coin = coin_scene.instantiate()
		coin.position = Vector2(1100,-10)
		coins_animation.append(coin)
	# print(coins_animation, self)

func spawn_coins(coin_position, obj):
	print("spawning coins id: ", obj)
	# print(coins_animation, self)
	for coin in coins_animation:
		print(coin)
		while(obj.find_child("Coin")): # TODO: change name key to search, this isn't working
			print("findind existing coins", obj.remove_child("Coin"))
		obj.add_child(coin)
		coin.position = Vector2(coin_position.x + randi_range(-50,50),coin_position.y + randi_range(-50,50))
		var tween = get_tree().create_tween().set_parallel(true)
		tween.tween_property(coin, "position", Vector2(1100, -10) , 1).set_ease(Tween.EASE_OUT)
		tween.play()
		coin.sound()
		
	Global.coins += Global.bonus


func spawn_food(station, sprite, obj):
	var food : Food = food_scene.instantiate()
	food.sprite_str = sprite
	food.position.x = station.position.x + 47
	food.position.y = station.position.y - 30
	food.on_station = station
	obj.add_child(food)

func spawn_ingredient(sprite, position, obj):
	var food : Food = food_scene.instantiate()
	food.sprite_str = sprite
	food.position = position
	obj.add_child(food)

func spawn_plate(position, obj):
	var plate : Plate = plate_scene.instantiate()
	plate.position.x = position.x - 60
	plate.position.y = position.y
	obj.add_child(plate)
