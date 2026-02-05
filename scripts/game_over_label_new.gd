extends Sprite2D
@onready var animated_sprite = get_node("/root/Main/Player/AnimatedSprite2D")
@onready var restart_button = get_node("/root/Main/CanvasLayer/RestartButton")  # Référence au bouton enfant
@onready var jauge = get_node("/root/Main/CanvasLayer/Jauge")

func _ready() -> void:
	# Centre automatiquement au milieu du viewport
	# Position de départ (hors écran, en haut)
	position.x = get_viewport_rect().size.x / 2
	position.y = -texture.get_height() / 2  # Hors de l'écran en haut
	
	add_to_group("game")
	
func animation():
	# Crée l'animation
	var tween = create_tween()
	var center_y = get_viewport_rect().size.y / 2
	
	# Anime la descente en 3 secondes avec un effet fluide
	tween.tween_property(self, "position:y", center_y, 2.0).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
	# Appelle show_button() 0.5s après la fin de l'animation
	tween.tween_callback(restart_button.show_button).set_delay(0.0)
		
func fin():
	# jauge.frame = 5
	visible = true
	animation()
	animated_sprite.play("frozen")
