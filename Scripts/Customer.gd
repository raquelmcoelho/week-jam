extends CharacterBody2D
class_name Customer

var customer_position
var customer_spot
var order = ""
var options = ["pasta", "sandwich", "soup"]
var skins = ["cartola", "laco", "paulin", "bone", "bigodon"]
var angry = "idle"

signal customer_gave_up()
signal customer_left(spot)

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
		angry = "die"
		$sad.play()
		$TimerSprite.visible = false
		emit_signal("customer_left", customer_spot)
		emit_signal("customer_gave_up")
		ajust_position(Vector2(900, 900))
	else:
		queue_free()

func _on_area_2d_area_entered(area):
	if area.is_in_group('food') and order == area.sprite_str:
		area.destroy()
		emit_signal("customer_left", customer_spot)
		angry = "die"
		$TimerSprite.visible = false
		ajust_position(Vector2(900, 900))
		Global.spawn_coins(self.position, get_parent())
		Global.spawn_plate(self.position, get_parent())
	elif area.is_in_group('food'):
		area.forbidden = self

func _on_area_2d_area_exited(area):
	if area.is_in_group('food') and area.forbidden == self:
		area.forbidden = null
