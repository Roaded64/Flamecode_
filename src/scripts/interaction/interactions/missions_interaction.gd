extends Node2D

@onready var interaction_area = $InteractionArea

@export var objectID: int

func _ready() -> void:
	match objectID:
		1:
			interaction_area.interact = Callable(self, "_piaturn")
		2:
			interaction_area.interact = Callable(self, "_banheiraturn")
		3:
			interaction_area.interact = Callable(self, "_lixojogue")

func _piaturn():
	$"../Pia/AnimationPlayer".play("static")
	await get_tree().create_timer(0.5).timeout
	Main.missionCompleted.emit()
	$"../Pia/InteractionArea".queue_free()

func _banheiraturn():
	$AnimationPlayer.play("staitc")
	await get_tree().create_timer(0.5).timeout
	Main.missionCompleted.emit()
	$InteractionArea.queue_free()

func _lixojogue():
	print("FUNCIONOOU DE NOVO E DE NOVO")
	
	await get_tree().create_timer(0.5).timeout
	Main.missionCompleted.emit()
	$InteractionArea.queue_free()
