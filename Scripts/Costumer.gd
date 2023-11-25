extends CharacterBody2D
class_name Costumer

var customer_position
var costumer_spot
var order = ""
var options = ["pasta", "sandwich", "soup"]
var skins = ["cartola", "laco", "paulin", "bone", "bigodon"]
var angry = "idle"

signal costumer_gave_up(costumer)

func _ready():
	$AnimatedSprite2D.play(skins[randi_range(0,4)])
	ajust_position(customer_position)

func ajust_position(new_position):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", new_position, 2).set_ease(Tween.EASE_OUT)

func order_something():
	order = options[randi_range(0,2)]
	$OrderBaloon.play("default")
	$OrderBaloon.visible = true
	$Order.play(order)
	$Order.visible = true
	angry = "green"
	$TimerSprite.play(angry)
	$TimerSprite.visible = true

func _on_timer_timeout():
	if angry == "idle":
		return
	if angry == "green":
		angry = "yellow"
		$TimerSprite.play(angry)
		$TimerSprite.visible = true
	elif angry == "yellow":
		angry = "red"
		$TimerSprite.play(angry)
		$TimerSprite.visible = true
	elif angry == "red":
		Main.costumer_out(costumer_spot)
		angry = "die"
		$TimerSprite.visible = false
		emit_signal("costumer_gave_up", self)
		ajust_position(Vector2(900, 900))
	else:
		queue_free()

func _on_area_2d_area_entered(area):
	if area.is_in_group('food') and order == area.sprite_str:
		area.queue_free()
		Main.costumer_out(costumer_spot)
		angry = "die"
		$TimerSprite.visible = false
		ajust_position(Vector2(900, 900))
		Main.spawn_coins()
	elif area.is_in_group('food'):
		area.forbidden = self

func _on_area_2d_area_exited(area):
	if area.is_in_group('food') and order == area.sprite_str:
		area.is_at_trash = false
	elif area.is_in_group('food') and area.forbidden == self:
		area.forbidden = null
