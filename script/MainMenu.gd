extends Control

var button_type = null
@onready var click: AudioStreamPlayer = $Click
@onready var hover: AudioStreamPlayer = $Hover
@onready var bell: AudioStreamPlayer = $Bell
@onready var music: AudioStreamPlayer = $Music

@onready var start_menu_sprite = $StartMenu
@onready var fade_transition = $Fade_Transition
@onready var fade_timer = $Fade_Transition/fade_timer
@onready var fade_anim = $Fade_Transition/AnimationPlayer

func _ready() -> void:
	# Pastikan musik jalan saat menu terbuka (opsional)
	if music and !music.playing:
		music.play()

# --- FUNGSI TOMBOL START ---
func _on_start_pressed() -> void:
	button_type = "start"
	
	# Mainkan suara Bell dan Click khusus untuk Start
	bell.play()
	click.play()
	
	start_menu_sprite.play("default") 
	
	await get_tree().create_timer(3.0).timeout
	
	fade_transition.show()
	fade_timer.start()
	fade_anim.play("fade_in")

# --- FUNGSI TOMBOL LAINNYA ---
func _on_options_pressed() -> void:
	click.play()
	# Tambahkan logika pindah menu opsi di sini

func _on_quit_pressed() -> void:
	click.play()
	# Memberi jeda sebentar agar suara klik terdengar sebelum quit
	await get_tree().create_timer(0.2).timeout
	get_tree().quit() 

func _on_credit_pressed() -> void:
	click.play()

func _on_sponsor_pressed() -> void:
	click.play()

# --- FUNGSI GLOBAL UNTUK HOVER ---
# Hubungkan sinyal "mouse_entered" dari SETIAP tombol ke fungsi ini
func _on_button_mouse_entered() -> void:
	hover.play()

# --- TIMEOUT ---
func _on_fade_timer_timeout() -> void:
	if button_type == "start":
		get_tree().change_scene_to_file("res://scenes/ui/loading.tscn")
