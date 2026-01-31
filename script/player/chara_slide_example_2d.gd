extends CharacterBody2D

const SPEED := 200.0

func _physics_process(delta):
	var direction := 0

	if Input.is_action_pressed("move_left"):
		direction -= 1
	if Input.is_action_pressed("move_right"):
		direction += 1

	velocity.x = direction * SPEED
	velocity.y = 0  # lock vertical movement

	move_and_slide()
