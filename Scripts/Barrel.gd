extends Area2D

var sprite_str

func _ready():
	self.z_index = 1
	$AnimatedSprite2D.play(sprite_str)

func _on_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("click"):
		Main.spawn_ingredient("ingredient_" + sprite_str, Vector2(self.position.x, self.position.y + 100))

func _on_mouse_entered():
	if not Main.is_dragging:
		scale = Vector2(2.1, 2.1)

func _on_mouse_exited():
	if not Main.is_dragging:
		scale = Vector2(2, 2)
