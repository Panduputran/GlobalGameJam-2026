extends Control

var button_type = null

# Referensi node biar lebih rapi (opsional, tapi disarankan)
@onready var start_menu_sprite = $StartMenu
@onready var fade_transition = $Fade_Transition
@onready var fade_timer = $Fade_Transition/fade_timer
@onready var fade_anim = $Fade_Transition/AnimationPlayer

func _ready() -> void:
	pass

func _on_start_pressed() -> void:
	button_type = "start"
	
	$StartMenu.play("default") 
	
	await get_tree().create_timer(3.0).timeout
	
	$Fade_Transition.show()
	$Fade_Transition/fade_timer.start()
	$Fade_Transition/AnimationPlayer.play("fade_in")

func _on_fade_timer_timeout() -> void:
	if button_type == "start":
		get_tree().change_scene_to_file("res://scenes/ui/loading.tscn")

func _on_options_pressed() -> void:
	pass 

func _on_quit_pressed() -> void:
	get_tree().quit() 
func _on_credit_pressed() -> void:
	pass 

func _on_sponsor_pressed() -> void:
	pass 
