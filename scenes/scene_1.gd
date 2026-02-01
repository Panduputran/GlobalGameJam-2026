extends Node2D

# --- KONFIGURASI PATH SCENE ---
# Ganti string ini sesuai lokasi file scene kamu
var game_over_scene = "res://scenes/game_over.tscn" 
var scene_2_path = "res://scenes/scene_2.tscn" 
func _on_area_2d_2_body_entered(body: Node2D) -> void:
	# Debugging: Lapor ke saya siapa pun yang menyentuh area ini!
	print("Sesuatu masuk area! Namanya: ", body.name) 
	
	if body.name == "ChibiRaana": # Pastikan nama ini sama persis dengan di Scene Tree
		print("Itu Player! Memulai dialog...")
		
		Dialogic.signal_event.connect(_on_dialogic_signal)
		Dialogic.start("timeline2")

func _on_dialogic_signal(argument: String):
	# Jika timeline mengirim sinyal "game_over"
	if argument == "game_over":
		Dialogic.signal_event.disconnect(_on_dialogic_signal)
		# (Opsional) Unpause game sebelum pindah
		# get_tree().paused = false 
		get_tree().change_scene_to_file(game_over_scene)
		
	# Jika timeline mengirim sinyal "option2"
	elif argument == "option2":
		Dialogic.signal_event.disconnect(_on_dialogic_signal)
		# (Opsional) Unpause game sebelum pindah
		# get_tree().paused = false
		get_tree().change_scene_to_file(scene_2_path)
