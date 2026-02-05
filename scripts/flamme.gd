extends Area2D
@export var speed = 250.0
@export var amplitude = 50.0  # Amplitude du mouvement vertical
@export var frequency = 2.0   # Vitesse de l'oscillation

var initial_y = 0.0
var time_elapsed = 0.0

func _ready():
	body_entered.connect(_on_body_entered)
	$AnimatedSprite2D.play("default")
	initial_y = position.y  # Sauvegarde la position Y de départ

func _process(delta):
	time_elapsed += delta
	
	# Déplacement horizontal
	position.x -= speed * delta
	
	# Mouvement sinusoïdal vertical
	position.y = initial_y + sin(time_elapsed * frequency) * amplitude

func _on_body_entered(body):
	if body.name == "Player":
		print("Le joueur a touché la Flamme !")
		
		# Accède au timer et réinitialise le temps
		var timer = get_node("/root/Main/CanvasLayer/Timer")
		if timer:
			timer.time_remaining = 15.0 
		
		# Détruit la flamme après récupération
		queue_free()
