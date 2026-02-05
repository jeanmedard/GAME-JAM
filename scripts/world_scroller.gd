extends Node

@export var scroll_speed_fond = 80.0
@export var scroll_speed_sol = 200.0

var is_scrolling = true  

@onready var sol = $"../Sol"  # Ajustez le chemin selon votre hiérarchie
@onready var fond = $"../Fond"  # Ajustez le chemin

func _ready():
	add_to_group("game")  # ← NOUVEAU

func fin():
	is_scrolling = false
	

func _process(delta):
	if not is_scrolling:  # ← NOUVEAU 
		return
		
	# Déplacer le sol vers la gauche
	if sol:
		sol.position.x -= scroll_speed_sol * delta
	
	# Déplacer le fond (si pas de caméra)
	if fond:
		fond.scroll_offset.x -= scroll_speed_fond * delta
