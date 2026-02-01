extends Node2D

@onready var logo_sponsor = $LogoSponsor
@onready var skip_label = $SkipLabel
@onready var logo_game: AnimatedSprite2D = $LogoGame
@onready var logo_ggj: AnimatedSprite2D = $LogoGGJ

const NEXT_SCENE_PATH := "res://scenes/ui/MainMenu.tscn"

var can_skip := false
var is_changing_scene := false
var blink_tween: Tween


func _ready():
	skip_label.visible = false
	skip_label.modulate.a = 0.0
	start_intro_sequence()


func _input(event):
	if not can_skip or is_changing_scene:
		return

	if event.is_action_pressed("ui_accept") or event.is_action_pressed("ui_select"):
		change_scene()


# =========================
# INTRO SEQUENCE
# =========================
func start_intro_sequence() -> void:
	# 1. GGJ DULU (DITUKAR)
	await play_logo_sequence(logo_ggj)
	
	# 2. BARU LOGO GAME
	await play_logo_sequence(logo_game)

	# 3. MUNCULKAN SKIP LABEL & SPONSOR
	show_skip_label()

	await play_logo_sequence(logo_sponsor)
	change_scene()


func play_logo_sequence(logo: AnimatedSprite2D) -> void:
	logo.visible = true
	logo.frame = 0
	logo.play("default")

	await logo.animation_finished
	await get_tree().create_timer(0.5).timeout

	logo.visible = false


# =========================
# SKIP LABEL
# =========================
func show_skip_label() -> void:
	can_skip = true
	skip_label.visible = true

	var tween := create_tween()
	tween.tween_property(skip_label, "modulate:a", 1.0, 1.0)
	tween.tween_callback(start_blink)


func start_blink() -> void:
	if blink_tween:
		blink_tween.kill()

	blink_tween = create_tween().set_loops()
	blink_tween.tween_property(skip_label, "modulate:a", 0.2, 0.8)
	blink_tween.tween_property(skip_label, "modulate:a", 1.0, 0.8)


# =========================
# SCENE CHANGE (SAFE)
# =========================
func change_scene() -> void:
	if is_changing_scene:
		return

	is_changing_scene = true
	can_skip = false

	if blink_tween:
		blink_tween.kill()

	get_tree().change_scene_to_file(NEXT_SCENE_PATH)
