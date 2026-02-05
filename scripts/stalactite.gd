extends Area2D

@export var speed = 300.0  # Vitesse en pixels/seconde (ajustable dans l'inspecteur)

func _ready():
	# Connecte le signal de collision
	body_entered.connect(_on_body_entered)
	
	# Démarre l'animation
	$AnimatedSprite2D.play("default")

func _process(delta):
	# Déplace vers la gauche
	position.x -= speed * delta

func _on_body_entered(body):
	# Quand quelque chose touche la stalactite
	if body.name == "Player":
		print("Le joueur a touché la stalactite!")
		
		
		get_tree().call_group("game", "fin")
