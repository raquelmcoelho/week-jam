extends CharacterBody2D

var position_in_line = 0;
var order = ""
var options = ["pasta", "sandwich", "soup"]
var skins = [
	"cartola", "laco", "paulin", "bone", "bigodon"
]

func _ready():
	$AnimatedSprite2D.play(skins[randi_range(0,4)])
	order = options[randi_range(0,2)]

func _physics_process(_delta):
	adjust_position_line()
	
func adjust_position_line():
	var place_offset = 80
	var screen_size = get_viewport().get_visible_rect().size
	var x_position = 0.7 * screen_size.x + (position_in_line * place_offset)
	var y_position = 0.3 * screen_size.y
	self.position = Vector2(x_position, y_position)
	
