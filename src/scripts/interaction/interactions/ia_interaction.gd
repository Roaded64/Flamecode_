extends Node2D

@onready var interaction_area = $InteractionArea

func _ready() -> void:
	interaction_area.interact = Callable(self, "_talk")

func _talk():
	if !Dialogic.is_playing:
		Dialogic.start("ia_timeline")
	else:
		pass
