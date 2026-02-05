extends CharacterBody2D

const JUMP_VELOCITY = -600.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_game_over = false

@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	add_to_group("game")
	animated_sprite.play("run")

# Ajoutez cette fonction _input en plus de votre code existant
func _input(event):
	# Détection du tap mobile et clic souris
	if (event is InputEventScreenTouch or event is InputEventMouseButton) and event.pressed:
		if is_on_floor():
			velocity.y = JUMP_VELOCITY

func _physics_process(delta: float) -> void:
	if is_game_over:
		return
	
	# Ajouter la gravité
	if not is_on_floor():
		velocity += get_gravity() * delta
		animated_sprite.play("jump")
	else:
		animated_sprite.play("run")  # ← Bien indenté (1 tab après else)
	
	# Gérer le saut
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	velocity.x = 0
	move_and_slide()

func fin():
	is_game_over = true
	
	# Arrête l'animation
	animated_sprite.stop()
	
	# Arrête le mouvement
	velocity = Vector2.ZERO
	
	# Arrête le physics_process
	set_physics_process(false)
