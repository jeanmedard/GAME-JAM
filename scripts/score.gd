extends Label

var score = 0
var score_timer = 0.0
var points_per_second = 10
var is_game_over = false  # ← Variable pour arrêter le score

func _ready():
	add_to_group("game")
	update_display()

func _process(delta: float):
	if is_game_over:  # ← VÉRIFIE si le jeu est terminé
		return  # ← Arrête tout si game over
	
	# Augmente le score au fil du temps
	score_timer += delta
	
	# Ajoute des points chaque seconde
	if score_timer >= 1.0:
		score += points_per_second
		score_timer = 0.0
		update_display()  # ← ENLÈVE le call_group d'ici !

func update_display():
	text = "Score  :  " + str(score)

# Fonction pour ajouter des points bonus
func add_points(points: int):
	score += points
	update_display()

# Fonction pour reset le score
func reset_score():
	score = 0
	score_timer = 0.0
	is_game_over = false  # ← Reset aussi le flag
	update_display()

# Appelé quand le jeu se termine (depuis Timer.gd)
func fin():
	print("SCORE ARRÊTÉ !")  # ← Pour vérifier
	is_game_over = true  # ← Active le flag pour arrêter _process
