extends Node

var fullscreen:bool

var debug_hud = preload("res://src/scenes/debug/debug_hud.tscn")
var debug = OS.is_debug_build()

var mission

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
	var mrn = rm.randi_range(0, 2)
	
	mission = mrn
	print(mrn)
