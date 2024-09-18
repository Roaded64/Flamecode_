extends Area2D

signal region_entered  # Sinal emitido quando o player entra na área
signal region_exited  # Sinal emitido quando o player sai da área

func _on_body_entered(body):
	if body.name == "Player":  # Substitua "Player" pelo nome do nó do seu personagem
		emit_signal("region_entered")

func _on_body_exited(body):
	if body.name == "Player":
		emit_signal("region_exited")
