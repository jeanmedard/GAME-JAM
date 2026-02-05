extends TextureButton

func _ready() -> void:
	visible = false
	position.x = get_viewport_rect().size.x / 2 - get_rect().size.x/2
	position.y = get_viewport_rect().size.y / 2 - 50
	pressed.connect(_on_pressed)

func show_button():
	visible = true
	# Animation d'apparition
	modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.3)

func _on_pressed():
	get_tree().reload_current_scene()
