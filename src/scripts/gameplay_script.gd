extends Node2D

# palavras pra ir pra roda!
const word = ["amante", "catapimbas", "mulher", "negro", "escravo"]
var rw
var curMission

@onready var label = $HUD/Label

# baguio do tempo
@onready var timer_progress = $HUD/ProgressBar
@onready var timer = $HUD/ProgressBar/Timer

func _ready():	
	# escolher a palavra aleatória
	rw = _random_word(word)
	
	label.text += str(rw)
	
	Dialogic.VAR.set('password', rw)
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Dialogic.signal_event.connect(_on_mission_signal)

func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_0):
		Dialogic.start("timeline_test")

func _on_dialogic_signal(argument:String):
	match argument:
		"conseguiu":
			print("acerto")
		"mission":
			curMission = 1
			$HUD/Label4.text += str(curMission)

func _on_mission_signal(argument:String):
	pass
#func _on_line_edit_text_submitted(word_try):
	#if word_try == rw:
		# acertou
		#print("acerto")
	#else:
		#errou
		#print("erro XD")

func _random_word(word):
	# até onde a escolha vai
	var w = randi() % len(word)
	# atribuir a varíavel das escolhas para a saida
	var out = word[w]

	return out


func _on_timer_timeout() -> void:
	timer_progress.value += 1
