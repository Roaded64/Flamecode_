extends CanvasLayer

@onready var debug01 = $Debug_01
@onready var debug02 = $Debug_02

func _process(_delta):
	var MEM = Performance.get_monitor(Performance.MEMORY_STATIC) / 104857.6
	var MEM_PEAK = Performance.get_monitor(Performance.MEMORY_STATIC_MAX) / 104857.6
	
	debug01.text = str(Engine.get_frames_per_second()) + " FPS"
	debug01.text += "\n" + str(round(MEM) / 10 ) + " MB / " + str(round(MEM_PEAK) / 10) + " MB"
	debug01.text += "\n" + "[FC.24aAT]" + "\n" + "\n"
	
	debug01.text += "DEBUG_BUILD"
	
	debug02.text = str(DisplayServer.window_get_size()) + "\n" + str(DisplayServer.screen_get_size())
