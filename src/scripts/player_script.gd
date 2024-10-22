extends CharacterBody2D

var playerSpeed = 275
var isRunning = false
var isUsing = false
var canUse = false
var state = "normal"
var placeUse = false

# se ele pode se mover ou não
var playerMove = true

@onready var playerSprite = $AnimatedSprite2D
@onready var progress = $"../CanvasLayer/TextureProgressBar"

# items
var baldeCheio = false

func _ready() -> void:
	state = "normal"

func _process(delta: float) -> void:
	if Dialogic.is_playing || Main.isCutscene:
		playerMove = false
		playerSprite.play("idle_" + state)
	elif !Dialogic.is_playing && !isUsing || !Main.isCutscene :
		playerMove = true
		
	if Input.is_action_just_pressed("key_use"):	
		if ItemData.item_data["balde"]["is_taken"] == true && baldeCheio == true:
			if canUse:
				isUsing = true
				
				playerSprite.play("baldeUse")
				baldeCheio = false
				playerMove = false
				$GPUParticles2D.emitting = true
				
				if placeUse == true:
					Main.useThing.emit()
				
				await get_tree().create_timer(0.7).timeout
				isUsing = false
				state = "balde"
				playerSprite.play("idle_" + state)
				playerMove = true
				$GPUParticles2D.emitting = false
			else:
				$"../cannot".play()
				
	if playerMove:
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
	
	if ItemData.item_data["balde"]["is_taken"] == true && !baldeCheio:
		state = "balde"
	elif ItemData.item_data["balde"]["is_taken"] == true && baldeCheio:
		state = "baldeCheio"
	else:
		state = "normal"
func _physics_process(_delta):
	# Fazer o vagabundo se mover
	if playerMove && !isUsing:
		var direction: Vector2 = Input.get_vector("key_left", "key_right", "key_up", "key_down")
		
		velocity.x = move_toward(velocity.x, playerSpeed * direction.x, playerSpeed)
		velocity.y = move_toward(velocity.y, playerSpeed * direction.y, playerSpeed)

		var player_direction = 1
		
		if Input.is_action_pressed("key_left"):
			playerSprite.scale.x = -5
			canUse = false
		elif Input.is_action_pressed("key_right"):
			playerSprite.scale.x = 5
			canUse = true
		
		if direction:
			playerSprite.play("run_" + state)
		else:
			playerSprite.play("idle_" + state)

		move_and_slide()

func fade(node, fade_duration, color):
	var fade_tween
	fade_tween = get_tree().create_tween()
	fade_tween.tween_property(node, "modulate", color, fade_duration)

func _on_timer_timeout() -> void:
	if !isRunning:
		progress.value += 0.4

func _on_area_2d_area_entered(area):
	pass
