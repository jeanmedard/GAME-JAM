extends Area2D

@export var speed = 200.0  # Vitesse en pixels/seconde (ajustable dans l'inspecteur)
@onready var animation = $AnimatedSprite2D
@onready var timer = get_node("/root/Main/CanvasLayer/Timer")

func _ready():
	# Connecte le signal de collision
	body_entered.connect(_on_body_entered)
	
	add_to_group("game")
	
	# Démarre l'animation
	$AnimatedSprite2D.play("default")

func _process(delta):
	# Déplace vers la gauche
	position.x -= speed * delta

func _on_body_entered(body):
	# Quand quelque chose touche la stalactite
	if body.name == "Player":
		print("Le joueur a touché les pics !")
		var membres = get_tree().get_nodes_in_group("game")
		print("Membres du groupe 'game': ", membres)
		get_tree().call_group("game", "fin")
		timer.game_over()
		
func fin():
	print("fin() appelée sur ", name)  # Debug
	set_process(false)
	
