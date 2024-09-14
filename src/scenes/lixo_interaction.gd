#extends Area2D

# Sinal para indicar que a lixeira foi usada
#signal lixeira_usada

# Referência ao jogador
#@onready var player = get_node("/root/Player")

#func _ready() -> void:
#connect("interaction_area", self, "_on_body_entered")

#func _on_body_entered(body):
	#if body == player:
		#if player.has_item("item_a_ser_descartado"):
		#	player.remove_item("item_a_ser_descartado")
		#	emit_signal("lixeira_usada")
		#	queue_free()  # Remove a lixeira da cena
		#	print("Item descartado e lixeira desativada.")
