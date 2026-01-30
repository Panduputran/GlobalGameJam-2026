extends Node2D

@onready var logo_game = $LogoGame
@onready var logo_ggj = $LogoGGJ
@onready var logo_sponsor = $LogoSponsor
@onready var skip_label = $SkipLabel

var next_scene_path = "res://scenes/ui/MainMenu.tscn"
var can_skip = false

func _ready():
	skip_label.visible = false
	skip_label.modulate.a = 0
	start_intro_sequence()

func _input(event):
	if can_skip and (event.is_action_pressed("ui_accept") or event.is_action_pressed("ui_select")):
		change_scene()

func start_intro_sequence():
	play_logo(logo_game)
	await logo_game.animation_finished
	await get_tree().create_timer(0.5).timeout
	logo_game.visible = false
	
	play_logo(logo_ggj)
	await logo_ggj.animation_finished
	await get_tree().create_timer(0.5).timeout
	logo_ggj.visible = false
	
	show_skip_label()
	
	play_logo(logo_sponsor)
	await logo_sponsor.animation_finished
	await get_tree().create_timer(0.5).timeout
	
	change_scene()

func show_skip_label():
	can_skip = true
	skip_label.visible = true
	
	var tween = create_tween()
	tween.tween_property(skip_label, "modulate:a", 1.0, 1.0)
	tween.tween_callback(loop_blink)

func loop_blink():
	var tween = create_tween().set_loops()
	tween.tween_property(skip_label, "modulate:a", 0.2, 0.8)
	tween.tween_property(skip_label, "modulate:a", 1.0, 0.8)

func play_logo(logo_node):
	logo_node.visible = true
	logo_node.frame = 0
	logo_node.play("default")

func change_scene():
	get_tree().change_scene_to_file(next_scene_path) 
