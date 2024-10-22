extends Control

@onready var buttons_menu = get_tree().get_nodes_in_group("buttons_menu")

func _ready() -> void:
	for button in get_tree().get_nodes_in_group("buttons_menu"):
		button.connect("pressed", self.on_button_pressed.bind(button))
		button.connect("mouse_exited", self.mouse_interaction.bind(button, "exited"))
		button.connect("mouse_entered", self.mouse_interaction.bind(button, "entered"))
		
	$AudioStreamPlayer2D/AnimationPlayer.play("fade")
	$ColorRect.visible = true
	var fade_tween
	fade_tween = get_tree().create_tween()
	fade_tween.tween_property($ColorRect, "modulate", Color.TRANSPARENT, 7)

func _process(delta: float) -> void:
	#_parallax($AnimatedSprite2D, 4, delta)
	$AnimatedSprite2D.position += (get_global_mouse_position()/1*delta)-$AnimatedSprite2D.position
	$Text.position += (get_global_mouse_position()/2*delta)-$Text.position

func on_button_pressed(button: Button) -> void:
	match button.name:
		"jogar":
			Transition.change_scene("res://src/scenes/gameplay_scene.tscn")
			$AudioStreamPlayer2D/AnimationPlayer.play("fadeout")
		
		"sair":
			get_tree().quit()

func mouse_interaction(button: Button, state: String) -> void:
	match state:
		"exited":
			button.modulate.a = 1.0
			
		"entered":
			button.modulate.a = 0.5

func _parallax(node, q, delta: float) -> void:
	node.position += (get_global_mouse_position()/q * delta)-node.position
