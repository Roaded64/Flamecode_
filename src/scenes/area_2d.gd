extends Area2D

@export var salaID = 1

func _ready() -> void:
	print(salaID)

func _on_body_entered(body: CharacterBody2D):
	Main.comodID = salaID
	print(Main.comodID)

func _on_body_exited(body: CharacterBody2D):
	Main.comodID = 1
