# StartScreen.gd (Scene: Control avec Label au centre)
extends Control

func _ready():
	$Label.text = "TAP   TO   START"
	
	# Centre le label sur l'écran
	$Label.set_anchors_preset(Control.PRESET_FULL_RECT)
	$Label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	$Label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER

func _input(event):
	if event is InputEventMouseButton or event is InputEventScreenTouch or event is InputEventKey:
		if event.pressed:
			# Démarre la musique
			if has_node("/root/MusicAutoload"):
				get_node("/root/MusicAutoload").play()
			# Lance le jeu
			get_tree().change_scene_to_file("res://scènes/main.tscn")
