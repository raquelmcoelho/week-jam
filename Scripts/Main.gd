extends Node

var coin_scene = load("res://Scenes/Coin.tscn")
var rat_scene = load("res://Scenes/Rat.tscn")
var food_scene = load("res://Scenes/Food.tscn")
var costumer_scene = load("res://Scenes/Costumer.tscn")
var barrel_scene = load("res://Scenes/Barrel.tscn")
var life_scene = load("res://Scenes/Life.tscn")

var line = []
var spots_positions = [Vector2(855, 270), Vector2(860, 360), Vector2(865, 450)]
var spots_num = 3
var bonus = 10
var coins = 1000
var lifes = []
var is_dragging = false

func receive_money():
	pass

func spawn_enemy():
	var rat = rat_scene.instantiate()
	print("enemies/Path2D%s/PathFollow2D" % [randi_range(1, 3)])
	var rat_spawn_location = get_node("enemies/Path2D%s/PathFollow2D" % [randi_range(1, 3)])
	if(not len(rat_spawn_location.get_children())):
		rat_spawn_location.progress_ratio = 0
		rat_spawn_location.add_child(rat)
	else:
		rat.queue_free()
	$enemies/EnemyTimer.wait_time = float(randi_range(20,30))
	$enemies/EnemyTimer.start()


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
	if spots_num != 0:
		var costumer = costumer_scene.instantiate()
		costumer.position = Vector2(1150, 0)
		costumer.customer_position = spots_positions[spots_num-1]
		add_child(costumer)
		spots_num -= 1

func spawn_lifes():
	for i in range(3):
		var life = life_scene.instantiate()
		life.position = Vector2(1100 + i * 35, 25)
		lifes.append(life)
		add_child(life)

func _on_enemy_timer_timeout():
	spawn_enemy()

func _on_creation_timer_timeout():
	spawn_lifes()
	spawn_barrel("pasta", Vector2(50,30))
	spawn_barrel("sandwich", Vector2(120,30))
	spawn_barrel("soup", Vector2(190,30))

func _on_customer_timer_timeout():
	spawn_clients()

func die():
	for i in range(2,0,-1):
		if(lifes[i].is_alive):
			lifes[i].kill()
			return
	print("game over")
	

