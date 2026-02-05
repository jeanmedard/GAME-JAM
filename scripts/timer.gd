extends Label

@onready var jauge = get_node("/root/Main/CanvasLayer/Jauge")
var time_remaining = 10.0  # Commence à 10 secondes
var is_game_over = false

# Précharge la scène
var stalactite_scene = preload("res://scènes/stalactite.tscn")
var pics_scene = preload("res://scènes/pics.tscn")

# Variables pour le spawn
var spawn_timer = 0.0
var next_spawn_time = 3.0  # Premier spawn dans 3 secondes

func spawn_obstacle(spawn_position: Vector2, type_obstacle:String):
	# Instancie la scène
	var obstacle
	
	match type_obstacle:
		"stalactite":
			obstacle = stalactite_scene.instantiate()
		"pics":
			obstacle = pics_scene.instantiate()
	# Positionne la stalactite
	obstacle.position = spawn_position
	# Ajoute à la scène PRINCIPALE (pas au Label!)
	get_tree().root.get_node("Main").add_child(obstacle)

func handle_stalactite_spawning(delta: float):
	# Gestion du spawn de stalactites
	spawn_timer += delta
	
	if spawn_timer >= next_spawn_time:
		# Spawn à droite de l'écran, hauteur 424px
		var spawn_x = get_viewport_rect().size.x  # Largeur de l'écran
		
		if randf() < 0.5:
			spawn_obstacle(Vector2(spawn_x, 424), "stalactite")
		else:
			spawn_obstacle(Vector2(spawn_x, 496), "pics")
			
		# Reset le timer et calcule le prochain temps de spawn (2-4 secondes)
		spawn_timer = 0.0
		next_spawn_time = randf_range(2.0, 4.0)  # 3s ± 1s

func _ready() -> void:
	add_to_group("timer")  # Pour reset_time depuis les flammes
	update_display()
	update_jauge()

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

func update_display():
	# Affiche le temps restant (arrondi)
	text = str(int(time_remaining)) + "s"

func reset_time():
	time_remaining = 10.0
	update_display()
	update_jauge()

func game_over():
	is_game_over = true
	# Envoie un signal à tous les nœuds du groupe "game"
	# get_tree().call_group("game", "on_game_over")
