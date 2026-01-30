extends Node2D

@onready var logo_godot = $LogoGodot
@onready var logo_ggj = $LogoGGJ
@onready var logo_team = $LogoTeam
@onready var logo_game = $LogoGame

var next_scene_path = "res://scenes/ui/MainMenu.tscn"

func _ready():
	start_sequence()

func _input(event):
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("ui_cancel"):
		skip_intro()

func start_sequence():
	logo_godot.visible = true
	logo_godot.play("default")
	await logo_godot.animation_finished
	# Opsional: Tambah delay biar gak terlalu cepat
	await get_tree().create_timer(0.5).timeout
	logo_godot.visible = false
	
	logo_ggj.visible = true
	logo_ggj.play("default")
	await logo_ggj.animation_finished
	await get_tree().create_timer(0.5).timeout
	logo_ggj.visible = false
	
	logo_team.visible = true
	logo_team.play("default")
	await logo_team.animation_finished
	await get_tree().create_timer(1.0).timeout
	
	change_to_main_menu()

func skip_intro():
	change_to_main_menu()

func change_to_main_menu():
	get_tree().change_scene_to_file(next_scene_path)
