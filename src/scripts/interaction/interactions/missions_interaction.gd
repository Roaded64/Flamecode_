extends Node2D

@onready var interaction_area = $InteractionArea

@export var objectID: int

var thing = 1

func _ready() -> void:
	match objectID:
		1:
			interaction_area.interact = Callable(self, "_piaturn")
		2:
			interaction_area.interact = Callable(self, "_banheiraturn")
		3:
			interaction_area.interact = Callable(self, "_lixojogue")

func _process(delta: float) -> void:
	if thing == 2:
		if $"../../..".i == 8:
			thing = 3

func _piaturn():
	if thing ==  1:
		$"../../Player/CharacterBody2D/Camera2D".apply_shake()
		await get_tree().create_timer(0.5).timeout
		thing = 2
		$"../Balde/Balde/InteractionArea".can_interact = true
		$"../../Fogos/FogoBanheiro".is_active = true
		$"../../Fogos/FogoBanheiro/PointLight2D5".visible = true
		#await get_tree().create_timer(1).timeout
		$"../../.."._fademission("Algum balde pode ajudar a apagar o fogo.")
	elif thing == 2:
		if ItemData.item_data["balde"]["is_taken"] == true:
			$"../../Player/CharacterBody2D".baldeCheio = true
			print($"../../Player/CharacterBody2D".baldeCheio)
	elif thing == 3:
		$"../Pia/AnimationPlayer".play("static")
		$"../../..".i = 9
		$"../../.."._fademission("SAIA DO BANHEIRO AGORA!")
		await get_tree().create_timer(1).timeout
		Main.missionCompleted.emit()
		$"../Pia/InteractionArea".queue_free()
		thing = 1

func _banheiraturn():
	if thing ==  1:
		$"../../Player/CharacterBody2D/Camera2D".apply_shake()
		await get_tree().create_timer(0.5).timeout
		thing = 2
		$"../Balde/Balde/InteractionArea".can_interact = true
		$"../../Fogos/FogoBanheiro".is_active = true
		$"../../Fogos/FogoBanheiro/PointLight2D5".visible = true
		$"../../.."._fademission("Algum balde pode ajudar a apagar o fogo.")
	elif thing == 2:
		if ItemData.item_data["balde"]["is_taken"] == true:
			$"../../Player/CharacterBody2D".baldeCheio = true
			print($"../../Player/CharacterBody2D".baldeCheio)
	elif thing == 3:
		$AnimationPlayer.play("staitc")
		Main.missionCompleted.emit()
		$InteractionArea.queue_free()
		thing = 1

func _lixojogue():
	print("FUNCIONOOU DE NOVO E DE NOVO")
	
	await get_tree().create_timer(0.5).timeout
	Main.missionCompleted.emit()
	$InteractionArea.queue_free()
