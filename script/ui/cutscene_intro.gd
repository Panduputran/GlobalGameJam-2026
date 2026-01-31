extends Control # atau Node2D, sesuaikan root node kamu

func _ready():
	# (Opsional) Kalau mau ada jeda hitam 4 detik sebelum dialog muncul seperti request sebelumnya:
	# await get_tree().create_timer(4.0).timeout
	
	# 1. Sambungkan sinyal
	Dialogic.signal_event.connect(_on_dialogic_signal)
	
	# 2. Mulai Timeline Intro
	Dialogic.start("timeline1")

func _on_dialogic_signal(argument: String):
	# Pastikan di akhir timeline1 kamu ada event Signal: "lanjut_loading"
	if argument == "lanjut_loading":
		Dialogic.signal_event.disconnect(_on_dialogic_signal)
		
		# Pindah ke scene Loading
		get_tree().change_scene_to_file("res://scenes/ui/Loading.tscn")
