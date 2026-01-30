extends Node2D

@onready var logo_game = $LogoGame
@onready var logo_ggj = $LogoGGJ
@onready var logo_sponsor = $LogoSponsor

var next_scene_path = "res://scenes/ui/MainMenu.tscn"

func _ready():
	start_intro_sequence()

func _input(event):
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("ui_cancel"):
		change_scene()

func start_intro_sequence():
	# 1. Mainkan Logo Game
	play_logo(logo_game)
	await logo_game.animation_finished
	await get_tree().create_timer(0.5).timeout
	logo_game.visible = false
	
	# 2. Mainkan Logo GGJ
	play_logo(logo_ggj)
	await logo_ggj.animation_finished
	await get_tree().create_timer(0.5).timeout
	logo_ggj.visible = false
	
	# 3. Mainkan Logo Sponsor
	play_logo(logo_sponsor)
	await logo_sponsor.animation_finished
	await get_tree().create_timer(0.5).timeout
	
	change_scene()

func play_logo(logo_node):
	logo_node.visible = true
	logo_node.frame = 0
	logo_node.play("default")

func change_scene():
	get_tree().change_scene_to_file(next_scene_path)
