extends CharacterBody2D

const SPEED = 450

# se ele pode se mover ou não
var playerMove = true

@onready var playerSprite = $AnimatedSprite2D 

func _physics_process(_delta):
	# Fazer o vagabundo se mover
	if playerMove:
		var direction: Vector2 = Input.get_vector("key_left", "key_right", "key_up", "key_down")
		
		velocity.x = move_toward(velocity.x, SPEED * direction.x, SPEED)
		velocity.y = move_toward(velocity.y, SPEED * direction.y, SPEED)

		if Input.is_action_pressed("key_left"):
			playerSprite.scale.x = -5
		elif Input.is_action_pressed("key_right"):
			playerSprite.scale.x = 5
		
		if direction:
			playerSprite.play("run")
		else:
			playerSprite.play("idle")

		move_and_slide()
