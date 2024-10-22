extends Node2D

@onready var interaction_area = $InteractionArea

@export var objectID: int

var thing = 1
var n = false

func _ready() -> void:
	match objectID:
		1:
			interaction_area.interact = Callable(self, "_piaturn")
		2:
			interaction_area.interact = Callable(self, "_banheiraturn")
		3:
			interaction_area.interact = Callable(self, "_lixojogue")

func _process(delta: float) -> void:
	if $"../../..".curMission == 1 || $"../../..".curMission == 2:
		if thing == 2:
			if $"../../..".i == 8:
				thing = 3
	elif $"../../..".curMission == 3:
		if thing == 1:
			thing = 2
	
	if n == false:
		if ItemData.item_data["lixoA"]["is_taken"] == true && ItemData.item_data["lixoB"]["is_taken"] == true && ItemData.item_data["lixoC"]["is_taken"] == true:
			$"../../.."._fademission("Jogue os resíduos na lixeira.")
			n = true

func _piaturn():
	_banheiro($"../Pia/AnimationPlayer", $"../Pia/InteractionArea")

func _banheiraturn():
	_banheiro($AnimationPlayer, $InteractionArea)

func _lixojogue():
	if thing == 1:
		$"../../.."._fademission("Pegue os resíduos antes de usar a lixeira.")
	elif thing == 2:
		if ItemData.item_data["lixoA"]["is_taken"] == true && ItemData.item_data["lixoB"]["is_taken"] == true && ItemData.item_data["lixoC"]["is_taken"] == true:
			$"../../Cozinha_Objects/Lixeira/LixeiraSprite".frame = 1
			$"../../Cozinha_Objects/Lixeira/InteractionArea".queue_free()
			$"../../..".good("Descartar o lixo corretamente mantém o \nambiente limpo e saudável, prevenindo a atração de pragas e doenças.", 1)
			#$"../../Cozinha_Objects/Lixos/LixoD/InteractionArea".can_interact = true
			#$"../../Cozinha_Objects/Lixos/LixoE/InteractionArea".can_interact = true
			#$"../../Cozinha_Objects/Lixos/LixoF/InteractionArea".can_interact = true
		else:
			$"../../.."._fademission("Pegue todos os resíduos antes de usar a lixeira.")
	elif thing == 3:
		await get_tree().create_timer(0.5).timeout
		Main.missionCompleted.emit()
		$InteractionArea.queue_free()

func _banheiro(node, interact):
	if thing ==  1:
		$"../../Player/CharacterBody2D/Camera2D".apply_shake()
		await get_tree().create_timer(0.5).timeout
		thing = 2
		$"../../Fogos/FogoBanheiro/StaticBody2D2/CollisionShape2D".disabled = false
		$"../Balde/Balde/InteractionArea".can_interact = true
		$"../../Fogos/FogoBanheiro".is_active = true
		$"../../Fogos/FogoBanheiro/PointLight2D5".visible = true
		#await get_tree().create_timer(1).timeout
		$"../../.."._fademission("Algum balde pode ajudar a apagar o fogo.")
	elif thing == 2:
		if ItemData.item_data["balde"]["is_taken"] == true:
			$"../../Player/CharacterBody2D".baldeCheio = true
	elif thing == 3:
		node.play("static")
		if $"../../..".curMission == 1:
			$"../../..".good("Economizar água potável evita desperdício e \najuda a preservar recursos naturais limitados.", 0)
		elif $"../../..".curMission == 2:
			$"../../..".good("Evitar o uso excessivo de água preserva o planeta e \nreduz o consumo energético relacionado ao tratamento e transporte de água.", 0)
			
		$"../../Fogos/FogoBanheiro/StaticBody2D2/CollisionShape2D".disabled = true
		#$"../../.."._fademission("SAIA DO BANHEIRO AGORA!")
		$"../../..".i = 9
		#await get_tree().create_timer(3).timeout
		Main.missionCompleted.emit()
		#$"../../.."._fademission("Você deveria falar com a IA novamente.")
		interact.queue_free()
		thing = 1
