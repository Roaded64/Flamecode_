extends Node2D

# palavras pra ir pra roda!
const word = ["IA", "Efeito Estufa", "Reflorestamento", "Sustentabilidade", "Aquecimento Global"]
var rw
var dica

var curMission
var misCompleted = 0

@onready var label = $HUD/Label

# baguio do tempo
@onready var timer_progress = $HUD/TextureProgressBar
@onready var timer = $HUD/TextureProgressBar/Timer

func _ready():	
	# escolher a palavra aleatória
	rw = _random_word(word)
	
	label.text = str(rw)
	
	Dialogic.VAR.set('password', rw)
	Dialogic.signal_event.connect(_on_dialogic_signal)
	
	Main.missionCompleted.connect(_mission_completed)
	
	# animação tocar
	$Scenes_Objects/Sala_Objects/Tv/AnimationPlayer.play("fogo")

func _process(delta: float) -> void:
	if timer_progress.value == 43:
		timer_progress.texture_progress = preload("res://assets/images/misc/termometro/termometro fases3.png")
	elif timer_progress.value == 77:
		timer_progress.texture_progress = preload("res://assets/images/misc/termometro/termometro fases4.png")
	elif timer_progress.value == 111:
		timer_progress.texture_progress = preload("res://assets/images/misc/termometro/termometro fases5.png")
	elif timer_progress.value == 144:
		timer_progress.texture_progress = preload("res://assets/images/misc/termometro/termometro fases6.png")
	
	if Main.comodID == 2:
		fade_in($Scenes_Objects/Banheiro_Objects, 0.4)
	elif Main.comodID == 3:
		fade_in($Scenes_Objects/Quarto_Objects, 0.4)
	else:
		fade_out($Scenes_Objects/Banheiro_Objects, 0.3)
		fade_out($Scenes_Objects/Quarto_Objects, 0.3)
		
		if Main.comodID != 1:
			fade_out($Scenes_Objects/Sala_Objects, 0.3)
	
func _on_dialogic_signal(argument:String):
	match argument:
		"conseguiu":
			print("acerto")
		"mission1":
			curMission = 1
			if curMission == 1:
				$Scenes_Objects/Banheiro_Objects/Pia/InteractionArea.can_interact = true
		"mission2":
			curMission = 2
			if curMission == 2:
				$Scenes_Objects/Banheiro_Objects/Banheira/InteractionArea.can_interact = true
		"mission3":
			curMission = 3
		"mission4":
			curMission = 4
	
	$HUD/Label4.text = "Sua missão atual é: " + str(curMission)

func _mission_completed():
	misCompleted == curMission
	
	if misCompleted == 1:
		Dialogic.start("mission2_AItimeline")

func _random_word(word):
	# até onde a escolha vai
	var w = randi() % len(word)
	# atribuir a varíavel das escolhas para a saida
	var out = word[w]

	return out

func fade_in(node:Node2D, fade_duration):
	var fade_tween = create_tween()
	#if fade_tween: fade_tween.kill()
	fade_tween = get_tree().create_tween()
	fade_tween.tween_property(node, "modulate", Color.WHITE, fade_duration)
	#fade_tween.finished.connect(func(): ready_to_fade_out = true)

func fade_out(node:Node2D, fade_duration):
	var fade_tween = Tween.new()
	#if fade_tween: fade_tween.kill()
	fade_tween = get_tree().create_tween()
	fade_tween.tween_property(node, "modulate", Color.BLACK, fade_duration)
	#fade_tween.finished.connect(func(): ready_to_fade_out = true)


func _on_timer_timeout() -> void:
	timer_progress.value += 1
