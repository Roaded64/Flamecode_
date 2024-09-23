extends Node

var fullscreen:bool

var debug_hud = preload("res://src/scenes/debug/debug_hud.tscn")
var debug = OS.is_debug_build()

var mission
var curMission = 0

var comodID = 1

signal missionCompleted

func _ready() -> void:
	# colocar a cena se for debug
	if debug:
		var debug_inst = debug_hud.instantiate()
		add_child(debug_inst)

func _process(_delta):
	# pra deixar tela cheia XD
	if Input.is_action_just_pressed("key_fullscreen"):
		fullscreen = !fullscreen
		
		if fullscreen:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	if debug:
		if Input.is_action_just_pressed("key_debug"):
			get_tree().reload_current_scene()

func _random_mission():
	var rm = RandomNumberGenerator.new()
	var mrn = rm.randi_range(1, 4)
	mission = mrn
	print(mrn)

# Tamanho da grade
const GRID_SIZE: int = 10

# Chance de o fogo se espalhar (0.0 a 1.0)
const SPREAD_CHANCE: float = 1.0

# Tempo em segundos entre cada tentativa de espalhar o fogo
const SPREAD_INTERVAL: float = 0.2

# Carrega a cena do fogo
@export var FireScene: PackedScene = preload("res://src/scenes/Fire.tscn")

# Inicializa a grade
var grid: Array = []

func _ready_fire() -> void:
	randomize()
	for i in range(GRID_SIZE):
		grid.append([])
	for j in range(GRID_SIZE):
		grid[j].append(null)
	# Inicia o fogo no centro
	add_fire(Vector2i(GRID_SIZE / 2, GRID_SIZE / 2))

# Função para adicionar fogo em uma posição
func add_fire(pos: Vector2i) -> void:
	if grid[pos.x][pos.y] == null:
		var fire_instance = FireScene.instantiate()
		fire_instance.position = pos * 20
		fire_instance.set("main_script", self)  # Atribui a referência do script principal
		add_child(fire_instance)
		grid[pos.x][pos.y] = fire_instance

# Função para obter os vizinhos de uma célula
func get_neighbors(pos: Vector2i) -> Array:
	var neighbors: Array = []
	if pos.x > 0 and grid[pos.x - 1][pos.y] == null:
		neighbors.append(Vector2i(pos.x - 1, pos.y))
	if pos.x < GRID_SIZE - 1 and grid[pos.x + 1][pos.y] == null:
		neighbors.append(Vector2i(pos.x + 1, pos.y))
	if pos.y > 0 and grid[pos.x][pos.y - 1] == null:
		neighbors.append(Vector2i(pos.x, pos.y - 1))
	if pos.y < GRID_SIZE - 1 and grid[pos.x][pos.y + 1] == null:
		neighbors.append(Vector2i(pos.x, pos.y + 1))
	return neighbors
