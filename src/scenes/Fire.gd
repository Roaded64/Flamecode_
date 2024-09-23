extends Sprite2D

# Referência ao script principal
@export var main_script: Node

# Função chamada a cada frame
func _process(delta: float) -> void:
	if main_script and Time.get_ticks_msec() % int(main_script.SPREAD_INTERVAL * 1000) == 0:
		spread_fire()

# Função para espalhar o fogo
func spread_fire() -> void:
	if main_script and randf() < main_script.SPREAD_CHANCE:
		var neighbors = main_script.get_neighbors(position)
		if neighbors.size() > 0:
			var new_pos = neighbors[randi() % neighbors.size()]
			main_script.add_fire(new_pos)
