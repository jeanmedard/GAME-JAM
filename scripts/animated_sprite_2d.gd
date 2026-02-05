extends AnimatedSprite2D

func _ready():
	animation_changed.connect(_on_animation_changed)

func _on_animation_changed():
	if animation == "run":
		$Course.play()
	else:
		$Course.stop()
