extends Area2D

@export var salaID = 1
@export var canSala = true
@export var useFire = false

func _on_body_entered(body: CharacterBody2D):
	if canSala == true:
		Main.comodID = salaID
		
	if useFire == true:
		body.placeUse = true

func _on_body_exited(body: CharacterBody2D):
	if canSala == true:
		Main.comodID = 1

	if useFire == true:
		body.placeUse = false
