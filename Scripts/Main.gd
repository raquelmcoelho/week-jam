extends Node

var rat_scene : PackedScene = preload("res://Scenes/Rat.tscn")
var costumer_scene : PackedScene = preload("res://Scenes/Costumer.tscn")
var barrel_scene : PackedScene = preload("res://Scenes/Barrel.tscn")
var life_scene : PackedScene = preload("res://Scenes/Life.tscn")

var line_positions = [Vector2(855, 120), Vector2(935, 120), Vector2(1015, 120), Vector2(1095, 120)]
var spots_positions = [Vector2(865, 450), Vector2(860, 360), Vector2(855, 270)]
var spots_ocuppied = [0, 0, 0]
var line = []
var costumer_spawn_time = 0
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

func update_costumers():
	var spot_index = -1
	for i in len(spots_ocuppied):
		if spots_ocuppied[i] == 0:
			spot_index = i
			break;
	if len(line) > 0 and spot_index != -1:
		spots_ocuppied[spot_index] = 1
		var costumer = line.pop_front()
		costumer.costumer_spot = spot_index
		costumer.ajust_position(spots_positions[spot_index])
		costumer.order_something()
		for i in range(len(line)):
			line[i].ajust_position(line_positions[i])
	else:
		if costumer_spawn_time == 4:
			costumer_spawn_time = 0
			spawn_costumer(spot_index)
		else:
			costumer_spawn_time += 1

func spawn_costumer(spot_index):
	if spot_index != -1:
		spots_ocuppied[spot_index] = 1
		var costumer : Costumer = costumer_scene.instantiate()
		costumer.connect("costumer_gave_up", Callable(self, "lose_life"))
		costumer.connect("costumer_left", Callable(self, "costumer_out"))
		costumer.position = Vector2(1150, 0)
		costumer.customer_position = spots_positions[spot_index]
		costumer.order_something()
		costumer.costumer_spot = spot_index
		add_child(costumer)
	elif len(line) < 4:
		var costumer : Costumer = costumer_scene.instantiate()
		costumer.connect("costumer_gave_up", Callable(self, "lose_life"))
		costumer.connect("costumer_left", Callable(self, "costumer_out"))
		costumer.position = Vector2(1150, 0)
		costumer.customer_position = line_positions[len(line)]
		add_child(costumer)
		line.append(costumer)

func costumer_out(costumer_spot):
	spots_ocuppied[costumer_spot] = 0

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
	update_costumers()

func lose_life():
	for i in range(2,0,-1):
		if(lifes[i].is_alive):
			lifes[i].kill()
			return
	get_tree().change_scene_to_file("res://Scenes/Game_over.tscn")


func _on_background_finished():
	$Background.play()
