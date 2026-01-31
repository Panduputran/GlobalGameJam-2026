extends Control

@onready var animation_player = $AnimationPlayer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var count_label = $count 

var progres = []
var sceneN
var sceneLS = 0
var loading_time = 0.0 
var is_fading = false 

func _ready():
	# 1. Pastikan visual loading terlihat (tidak tertutup ColorRect hitam di awal)
	# Jika kamu pakai ColorRect untuk fade, set opacity-nya ke 0 dulu
	# atau pastikan AnimatedSprite2D memiliki Z-index lebih tinggi.
	
	sceneN = "res://scenes/ui/CutsceneIntro.tscn"
	ResourceLoader.load_threaded_request(sceneN)
	
	if animated_sprite_2d:
		animated_sprite_2d.show() # Pastikan tidak tersembunyi
		animated_sprite_2d.play("default") 

func _process(delta):
	loading_time += delta
	sceneLS = ResourceLoader.load_threaded_get_status(sceneN, progres)
	
	# Update teks persentase visual
	var visual_progress = min((loading_time / 5.0) * 100, 100)
	if count_label:
		count_label.text = str(floor(visual_progress)) + "%"

	# Pastikan animasi tetap play (terkadang terhenti jika scene berat)
	if animated_sprite_2d and not animated_sprite_2d.is_playing():
		animated_sprite_2d.play("default")

	if sceneLS == ResourceLoader.THREAD_LOAD_LOADED and loading_time >= 5.0 and not is_fading:
		start_transition_out()

func start_transition_out():
	is_fading = true
	
	if animation_player:
		# Jika 'fade_in' adalah animasi yang membuat layar jadi HITAM
		animation_player.play("fade_in") 
		await animation_player.animation_finished 
	
	var new = ResourceLoader.load_threaded_get(sceneN)
	if new:
		get_tree().change_scene_to_packed(new)
