extends Control

# Pastikan node VideoStreamPlayer kamu sudah punya resource video (.ogv) di dalamnya
@onready var video_stream_player: VideoStreamPlayer = $VideoStreamPlayer

func _ready():
	# 1. Sambungkan sinyal Dialogic (Listening)
	Dialogic.signal_event.connect(_on_dialogic_signal)
	
	# 2. Mainkan Video
	video_stream_player.play()
	
	# 3. Tunggu sampai video benar-benar selesai diputar
	# (Script akan berhenti di baris ini selama durasi video, misal 30 detik)
	await video_stream_player.finished
	
	# 4. Setelah video habis, baru Mulai Timeline 1
	Dialogic.start("timeline1")

func _on_dialogic_signal(argument: String):
	# Mengecek sinyal "option1" dari Timeline (sesuai request)
	if argument == "option1":
		# Putuskan koneksi sinyal biar bersih
		Dialogic.signal_event.disconnect(_on_dialogic_signal)
		
		# Ganti scene ke scene1.tscn
		get_tree().change_scene_to_file("res://scenes/scene_1.tscn")
