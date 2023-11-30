extends Node

var rat_scene : PackedScene = preload("res://Objects/Rat.tscn")
var customer_scene : PackedScene = preload("res://Objects/Customer.tscn")
var barrel_scene : PackedScene = preload("res://Objects/Barrel.tscn")
var life_scene : PackedScene = preload("res://Objects/Life.tscn")

var line_positions = [Vector2(855, 120), Vector2(935, 120), Vector2(1015, 120), Vector2(1095, 120)]
var spots_positions = [Vector2(865, 450), Vector2(860, 360), Vector2(855, 270)]
var spots_ocuppied = [0, 0, 0]
var line = []
var customer_spawn_time = 0
var lifes = []

func _ready():
	print("main ready id: ", self)
	

func spawn_enemy():
	var rat : Enemy = rat_scene.instantiate()
	var rat_spawn_location = get_node("Path2D%s/PathFollow2D" % [randi_range(1, 3)])
	if(not len(rat_spawn_location.get_children())):
		rat_spawn_location.progress_ratio = 0
		rat_spawn_location.add_child(rat)
	else:
		rat.queue_free()
	$EnemyTimer.wait_time = float(randi_range(10,20))
	$EnemyTimer.start()

func spawn_barrel(sprite, position):
	var barrel = barrel_scene.instantiate()
	barrel.sprite_str = sprite
	barrel.position = position
	add_child(barrel)

func update_customers():
	var spot_index = -1
	for i in len(spots_ocuppied):
		if spots_ocuppied[i] == 0:
			spot_index = i
			break;
	if len(line) > 0 and spot_index != -1:
		spots_ocuppied[spot_index] = 1
		var customer = line.pop_front()
		customer.customer_spot = spot_index
		customer.ajust_position(spots_positions[spot_index])
		customer.order_something()
		for i in range(len(line)):
			line[i].ajust_position(line_positions[i])
	else:
		if customer_spawn_time == 4:
			customer_spawn_time = 0
			spawn_customer(spot_index)
		else:
			customer_spawn_time += 1

func spawn_customer(spot_index):
	if spot_index != -1:
		spots_ocuppied[spot_index] = 1
		var customer : Customer = customer_scene.instantiate()
		customer.connect("customer_gave_up", Callable(self, "lose_life"))
		customer.connect("customer_left", Callable(self, "customer_out"))
		customer.position = Vector2(1150, 0)
		customer.customer_position = spots_positions[spot_index]
		customer.order_something()
		customer.customer_spot = spot_index
		add_child(customer)
	elif len(line) < 4:
		var customer : Customer = customer_scene.instantiate()
		customer.connect("customer_gave_up", Callable(self, "lose_life"))
		customer.connect("customer_left", Callable(self, "customer_out"))
		customer.position = Vector2(1150, 0)
		customer.customer_position = line_positions[len(line)]
		add_child(customer)
		line.append(customer)

func customer_out(customer_spot):
	spots_ocuppied[customer_spot] = 0

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
	spawn_barrel("pasta", Vector2(50,225))
	spawn_barrel("sandwich", Vector2(120,200))
	spawn_barrel("soup", Vector2(190,175))

func _on_customer_timer_timeout():
	update_customers()

func lose_life():
	for i in range(2,0,-1):
		if(lifes[i].is_alive):
			lifes[i].kill()
			return
	get_tree().change_scene_to_file("res://Scenes/Game_over.tscn")


func _on_background_finished():
	$Background.play()

func coin_sound():
	$CoinSound.play()
