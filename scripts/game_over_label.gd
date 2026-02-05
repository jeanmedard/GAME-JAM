extends Label

@onready var animated_sprite = get_node("/root/Main/Player/AnimatedSprite2D")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("game")
	

func fin():
	visible = true
	animated_sprite.play("frozen")
