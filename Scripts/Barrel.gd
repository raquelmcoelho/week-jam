extends Area2D

@export var sprite = CompressedTexture2D
@export var sprite_str: String

func _ready():
	$Sprite2D.texture = sprite

func _on_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("click") and not Global.is_dragging:
		Global.spawn_ingredient("ingredient_" + sprite_str, Vector2(self.position.x, self.position.y + 100), get_parent())

func _on_mouse_entered():
	if not Global.is_dragging:
		scale = Vector2(2.1, 2.1)

func _on_mouse_exited():
	if not Global.is_dragging:
		scale = Vector2(2, 2)

func _on_area_entered(area):
	if area.is_in_group('food') and "ingredient_"+sprite_str == area.sprite_str:
		area.is_at_trash = true
	else:
		area.forbidden = self

func _on_area_exited(area):
	if area.is_in_group('food') and "ingredient_"+sprite_str == area.sprite_str:
		area.is_at_trash = false
	elif area.forbidden == self:
		area.forbidden = null

