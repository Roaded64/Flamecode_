extends CharacterBody2D


var playerSpeed = 275
var isRunning = false

# se ele pode se mover ou não
var playerMove = true

@onready var playerSprite = $AnimatedSprite2D

func _process(delta: float) -> void:
	if Dialogic.is_playing:
		playerMove = false
		playerSprite.play("idle")
	elif !Dialogic.is_playing:
		playerMove = true
	
	if Input.is_action_pressed("key_run"):
		playerSpeed = 500
		isRunning = true
	else:
		playerSpeed = 275
		isRunning = false

func _physics_process(_delta):
	# Fazer o vagabundo se mover
	if playerMove:
		var direction: Vector2 = Input.get_vector("key_left", "key_right", "key_up", "key_down")
		
		velocity.x = move_toward(velocity.x, playerSpeed * direction.x, playerSpeed)
		velocity.y = move_toward(velocity.y, playerSpeed * direction.y, playerSpeed)

		if Input.is_action_pressed("key_left"):
			playerSprite.scale.x = -5
		elif Input.is_action_pressed("key_right"):
			playerSprite.scale.x = 5
		
		if direction:
			playerSprite.play("run")
		else:
			playerSprite.play("idle")

		move_and_slide()
