extends Control

@onready var buttons_menu = get_tree().get_nodes_in_group("buttons_menu")

func _ready() -> void:
	for button in get_tree().get_nodes_in_group("buttons_menu"):
		button.connect("pressed", self.on_button_pressed.bind(button))
		button.connect("mouse_exited", self.mouse_interaction.bind(button, "exited"))
		button.connect("mouse_entered", self.mouse_interaction.bind(button, "entered"))


func on_button_pressed(button: Button) -> void:
	match button.name:
		"jogar":
			Transition.change_scene("res://src/scenes/cut_scene.tscn")
		
		"sair":
			get_tree().quit()

func mouse_interaction(button: Button, state: String) -> void:
	match state:
		"exited":
			button.modulate.a = 1.0
			
		"entered":
			button.modulate.a = 0.5
