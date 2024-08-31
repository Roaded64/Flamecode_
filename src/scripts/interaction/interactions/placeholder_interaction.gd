extends Node2D

# esse arquivo é de base e teste para as interações, ou caso vc nn tiver uma e quiser usar outra por enquanto

@onready var interaction_area = $InteractionArea

func _ready() -> void:
	interaction_area.interact = Callable(self, "_print")

func _print():
	print("FUNCIONOOU")
	#Dialogic.start("timeline_test")

# para colocar dialogo
# Dialogic.start("nome_da_timeline")

# para utilizar o itemdata
#if ItemData.item_data["placeholder"]["is_taken"] == true:
		#print("FUNCIONOOU")
	#else:
		#print("NÃO ESTÁ ATIVADO")
