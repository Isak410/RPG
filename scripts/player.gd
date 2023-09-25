extends CharacterBody2D

const speed = 100
var current_dir = "none"
var ctrlToggle = true
var CorrectSound = preload("res://Sounds/Baddadan.wav")
var pressed1 = false

func _ready():
	$AnimatedSprite2D.play("front_idle")

func _process(delta: float) -> void:
	if pressed1 == true:
		if !$AudioStreamPlayer2D.is_playing():
			$AudioStreamPlayer2D.stream = CorrectSound
			$AudioStreamPlayer2D.play()
			pressed1 = false

func _physics_process(delta):
	player_movement(delta)

func player_movement(delta):
	if Input.is_action_pressed("pressedD"):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
		
	elif Input.is_action_pressed("pressedA"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("pressedS"):
		current_dir = "down"
		play_anim(1)
		velocity.y = speed
		velocity.x = 0
	elif Input.is_action_pressed("pressedW"):
		current_dir = "up"
		play_anim(1)
		velocity.y = -speed
		velocity.x = 0
	elif Input.is_action_just_pressed("pressedH"):
		pressed1 = true
		_process(1)
	elif Input.is_action_just_pressed("ctrlPressed"):
		current_dir = "ctrl"
		play_anim(1)
		velocity.y = 0
		velocity.x = 0
		if (current_dir != "ctrl"):
			play_anim(0)
			velocity.x = 0
			velocity.y = 0
	move_and_slide()

func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D

	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
	if dir == "down":
		anim.flip_h = false
		if movement == 1:
			anim.play("front_walk")
		elif movement == 0:
			anim.play("front_idle")
	if dir == "up":
		anim.flip_h = false
		if movement == 1:
			anim.play("back_walk")
		elif movement == 0:
			anim.play("back_idle")
	if dir == "ctrl":
		anim.flip_h = false
		if (ctrlToggle == true):
			anim.play("crouch")
			ctrlToggle = false
		elif (ctrlToggle == false):
			anim.play("side_idle")
			ctrlToggle = true
