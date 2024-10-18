extends Node2D

@export var animation_player : AnimationPlayer
@export var autoplay : bool = false
@export var next_scene : PackedScene
@export var camera : Camera2D

var shake_strength: float = 0.0
var DECAY_RATE: float = 5.0

func _ready() -> void:
	Main.isCutscene = true

func _input(event):
	if event.is_action_pressed("key_next") and not animation_player.is_playing():
		animation_player.play()
		
func pause():
	if autoplay==false:
		animation_player.pause()
	
func apply_shake():
	shake_strength = 10
	
func _process(delta):
	shake_strength= lerp(shake_strength, 0.0, DECAY_RATE * delta)
	camera.offset = get_random_offset()
	
	if Main.debug:
		if Input.is_key_pressed(KEY_ENTER):
			Transition.change_scene("res://src/scenes/gameplay_scene.tscn")
			Main.isCutscene = false
	
func get_random_offset() -> Vector2:
	return Vector2(
	randf_range(-shake_strength, shake_strength),
	randf_range(-shake_strength, shake_strength)
	)
	
func _on_timer_timeout() -> void:
	Transition.change_scene("res://src/scenes/gameplay_scene.tscn")
	Main.isCutscene = false
