extends CharacterBody2D

const SPEED = 300.0
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	# 1. Ambil input arah (Vector2)
	var direction := Input.get_vector("left", "right", "up", "down")
	
	if direction != Vector2.ZERO:
		velocity = direction * SPEED
		anim.play("walk")
		
		# --- LOGIKA ARAH HADAP (ASUMSI ASET ASLI HADAP KIRI) ---
		if direction.x > 0:
			# Jika bergerak ke KANAN, aktifkan Flip (supaya menghadap kanan)
			anim.flip_h = true
		elif direction.x < 0:
			# Jika bergerak ke KIRI, matikan Flip (kembali ke asal/hadap kiri)
			anim.flip_h = false
			
	else:
		# Berhenti dengan halus
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
		anim.play("idle")

	move_and_slide()

	# 2. Logika Interaksi
	if Input.is_action_just_pressed("ui_accept"):
		interact()

func interact():
	print("Mencoba berinteraksi...")
