extends AnimatedSprite2D

var game_started = false

func _ready():
	animation_changed.connect(_on_animation_changed)
	# Attend un court instant avant d'activer les sons
	await get_tree().create_timer(0.1).timeout
	game_started = true
	add_to_group("game")

func _on_animation_changed():
	if not game_started:
		return
		
	if animation == "run":
		$Course.play()
	elif animation == "jump":
		$Saut.play()
		$Course.stop()
		
func fin():
	$Course.stop()
