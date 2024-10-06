extends CharacterBody2D


var playerSpeed = 275
var isRunning = false

# se ele pode se mover ou não
var playerMove = true

@onready var playerSprite = $AnimatedSprite2D
@onready var progress = $"../CanvasLayer/TextureProgressBar"

func _ready() -> void:
	if Main.isCutscene:
		playerMove = false
	else:
		playerMove = true

func _process(delta: float) -> void:
	if Dialogic.is_playing:
		playerMove = false
		playerSprite.play("idle")
	elif !Dialogic.is_playing:
		playerMove = true
	
	if Input.is_action_pressed("key_run"):
		if progress.value > 40:
			isRunning = true
	else:
		isRunning = false

	if progress.value == 0:
		isRunning = false

	if isRunning:
		progress.value -= 0.4
		fade(progress, 0.7, Color.WHITE)
		playerSpeed = 500
	else:
		fade(progress, 0.7, Color.TRANSPARENT)
		playerSpeed = 275
		
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

func fade(node, fade_duration, color):
	var fade_tween
	fade_tween = get_tree().create_tween()
	fade_tween.tween_property(node, "modulate", color, fade_duration)

func _on_timer_timeout() -> void:
	if !isRunning:
		progress.value += 0.4
