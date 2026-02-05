extends Node
@export var scroll_speed_fond = 80.0
@export var scroll_speed_sol = 200.0

var is_scrolling = true  
var sol_width = 0.0

@onready var sol1 = $"../Sol 1"
@onready var sol2 = $"../Sol 2"
@onready var sol3 = $"../Sol 3"

@onready var fond = $"../Fond"

func _ready():
	add_to_group("game")
	
	# Détecte automatiquement la largeur du TileMapLayer
	if sol1 is TileMapLayer:
		var used_rect = sol1.get_used_rect()
		var tile_size = sol1.tile_set.tile_size
		sol_width = used_rect.size.x * tile_size.x * sol1.scale.x
		print("Largeur du sol détectée : ", sol_width)
	else:
		print("Erreur : sol1 n'est pas un TileMapLayer")

func fin():
	is_scrolling = false
	
func gestion_sols(delta):
	# Déplacer le sol vers la gauche
	sol1.position.x -= scroll_speed_sol * delta
	sol2.position.x -= scroll_speed_sol * delta
	sol3.position.x -= scroll_speed_sol * delta
	
	# Repositionnement infini du sol 1
	if sol1.position.x <= -sol_width-50.0:
		sol1.position.x = sol3.position.x + sol_width
	
	# Repositionnement infini du sol 2
	if sol2.position.x <= -sol_width-50.0:
		sol2.position.x = sol1.position.x + sol_width
		
		# Repositionnement infini du sol 2
	if sol3.position.x <= -sol_width-50.0:
		sol3.position.x = sol2.position.x + sol_width
	
	
func _process(delta):
	if not is_scrolling:
		return
		
	gestion_sols(delta)

	# Déplacer le fond
	if fond:
		fond.scroll_offset.x -= scroll_speed_fond * delta
