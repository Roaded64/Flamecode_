extends Node2D

@onready var interaction_area = $InteractionArea

@export var objectID: int

func _ready() -> void:
	if objectID == 1:
		interaction_area.interact = Callable(self, "_print")

func _print():
	print("FUNCIONOOU")
	
	await get_tree().create_timer(0.5).timeout
	Main.missionCompleted.emit()
