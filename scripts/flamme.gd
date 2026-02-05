extends Area2D

@export var speed = 300.0

func _ready():
	body_entered.connect(_on_body_entered)
	$AnimatedSprite2D.play("default")

func _process(delta):
	position.x -= speed * delta

func _on_body_entered(body):
	if body.name == "Player":
		print("Le joueur a touché la Flamme !")
		
		# Accède au timer et réinitialise le temps
		var timer = get_node("/root/Main/CanvasLayer/Timer")  # Adaptez le chemin
		if timer:
			timer.time_remaining = 100.0
		
		# Détruit la flamme après récupération
		queue_free()
