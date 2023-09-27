extends CharacterBody2D

var enemy_inattack_range = false
var enemy_attack_cooldown = true
var health = 200
var player_alive = true


const speed = 100
var current_dir = "none"
var ctrlToggle = true
var CorrectSound = preload("res://Sounds/Baddadan.wav")
var pressed1 = false

var attack_ip = false

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
	enemy_attack()
	attack()
	
	if (health <= 0):
		player_alive = false #gå til meny
		health = 0
		print("player has been killed")
		self.queue_free()

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
	else:
		play_anim(0)
		velocity.y = 0
		velocity.x = 0
	move_and_slide()

func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D

	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("side_idle")
	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("side_idle")
	if dir == "down":
		anim.flip_h = false
		if movement == 1:
			anim.play("front_walk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("front_idle")
	if dir == "up":
		anim.flip_h = false
		if movement == 1:
			anim.play("back_walk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("back_idle")
	if dir == "ctrl":
		if movement == 1:
			anim.flip_h = false
			if (ctrlToggle == true):
				anim.play("crouch")
				ctrlToggle = false
			elif (ctrlToggle == false):
				anim.play("side_idle")
				ctrlToggle = true
			
func player():
	pass

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true
		


func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = false
		
func enemy_attack():
	if enemy_inattack_range == true and enemy_attack_cooldown == true :
		health = health - 20
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(health)
	


func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true
	
func attack():
	
	var dir = current_dir
	
	if Input.is_action_just_pressed("attack"):
		Global.player_current_attack = true
		attack_ip = true
		if dir == "right":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("side_attack")
			$deal_attack_timer.start()
		if dir == "left":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("side_attack")
			print("side attack performed")
			$deal_attack_timer.start()
		if dir == "down":
			$AnimatedSprite2D.play("front_attack")
			$deal_attack_timer.start()
		if dir == "up":
			$AnimatedSprite2D.play("back_attack")
			$deal_attack_timer.start()

func _on_deal_attack_timer_timeout():
	print("attack timer run out")
	$deal_attack_timer.stop()
	Global.player_current_attack = false
	attack_ip = false
