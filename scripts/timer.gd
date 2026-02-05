extends Label

@onready var jauge = get_node("/root/Main/CanvasLayer/Jauge")
var time_remaining = 10.0  # Commence à 10 secondes
var is_game_over = false

# FMOD
var music_event
var fmod_parameter_changed = false
# FMOD


# Précharge la scène
var stalactite_scene = preload("res://scènes/stalactite.tscn")
var pics_scene = preload("res://scènes/pics.tscn")


# Variables pour le spawn
var spawn_timer = 0.0
var next_spawn_time = 3.0  # Premier spawn qdans 3 secondes

func spawn_obstacle(spawn_position: Vector2, type_obstacle: String):
	# Instancie la scène
	var obstacle
	match type_obstacle:
		"stalactite":
			obstacle = stalactite_scene.instantiate()
			# Positionne la stalactite
		"pics":
			obstacle = pics_scene.instantiate()
			
	obstacle.position = spawn_position
			# Ajoute à la scène PRINCIPALE (pas au Label!)

	get_tree().root.get_node("Main").add_child(obstacle)
		
	

func handle_stalactite_spawning(delta: float):
	# Gestion du spawn de stalactites
	spawn_timer += delta
	
	if spawn_timer >= next_spawn_time:
		# Spawn à droite de l'écran, hauteur 424px
		var spawn_x = get_viewport_rect().size.x  # Largeur de l'écran
		spawn_obstacle(Vector2(spawn_x, 424), "pics")
		
		# Reset le timer et calcule le prochain temps de spawn (2-4 secondes)
		spawn_timer = 0.0
		next_spawn_time = randf_range(1.0, 4.0)  # 3s ± 1s

func _ready() -> void:
	add_to_group("timer")  # Pour reset_time depuis les flammes
	update_display()
	update_jauge()
	
	
	# Trouve l'event FMOD automatiquement
	music_event = get_tree().root.find_child("FmodEventEmitter2D", true, false)
	

func _process(delta: float) -> void:
	if is_game_over:
		return  # Ne rien faire si le jeu est terminé
	
	# Diminue le temps
	time_remaining -= delta
	
	update_jauge()
	
	# Appelle la fonction de spawn
	handle_stalactite_spawning(delta)
	
	# Vérifie si le temps est écoulé
	if time_remaining <= 1:
		time_remaining = 0
		get_tree().call_group("game", "fin")
	
	update_display()

func update_jauge():
	# Calcule automatiquement la frame en fonction du temps
	# 10s = frame 0, 8s = frame 1, 6s = frame 2, etc.
	var frame_index = 4 - int(time_remaining / 2.0)
	
	# S'assure que l'index est dans les limites (0-4)
	frame_index = clamp(frame_index, 0, 4)
	
	jauge.frame = frame_index
	
	
	
# Gestion dynamique du paramètre FMOD
	if music_event:
		if time_remaining <= 8.0:
			# Sous 8s = intensité 2
			if not fmod_parameter_changed:
				
				music_event.set_parameter("Intensity", 2.0)
				fmod_parameter_changed = true
		else:
			# Au-dessus de 8s = intensité 1
			if fmod_parameter_changed:
				
				music_event.set_parameter("Intensity", 1.0)
				fmod_parameter_changed = false

func update_display():
	# Affiche le temps restant (arrondi)
	text = str(int(time_remaining)) + "s"
	
	# Change la couleur si le temps est faible
	if time_remaining <= 3:
		modulate = Color.RED  # Rouge dans les 3 dernières secondes
	elif time_remaining <= 5:
		modulate = Color.ORANGE  # Orange quand il reste moins de 5 secondes
	else:
		modulate = Color.WHITE

func reset_time():
	time_remaining = 10.0
	fmod_parameter_changed = false  # RESET aussi le flag FMOD !
	update_display()
	update_jauge()

func game_over():
	is_game_over = true
	# Envoie un signal à tous les nœuds du groupe "game"
	get_tree().call_group("game", "on_game_over")
