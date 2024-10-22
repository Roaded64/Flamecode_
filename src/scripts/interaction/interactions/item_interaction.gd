extends Node2D

# esse arquivo é de base e teste para as interações, ou caso vc nn tiver uma e quiser usar outra por enquanto

@export var item_name: String
@export var has_sound: AudioStreamPlayer2D

@onready var interaction_area = $InteractionArea
@onready var parent = $"."

func _ready() -> void:
	interaction_area.interact = Callable(self, "_take")

func _take():
	parent.queue_free()
	
	if has_sound != null:
		has_sound.play()
	
	ItemData.change_json_file(item_name)
	
	#Playstate._item_hud(ItemData.item_data[item_name], ItemData.item_data[item_name]["desc"])
	
	print(ItemData.item_data[item_name])
