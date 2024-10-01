extends Node2D

# palavras para as missões
const word = ["IA", "Sustentabilidade", "Aquecimento Global"]
var rw
var dica

# múltiplas dicas associadas às palavras (em diferentes níveis de clareza)
const dicas = {
	"IA": ["Refere-se à criação de máquinas que podem 'pensar'.", "É usada em muitos campos, incluindo tecnologia.", "É uma abreviação de Inteligência Artificial."],
	#"Efeito Estufa": ["Relacionado ao aquecimento da superfície da Terra.", "Ocorre quando gases ficam presos na atmosfera.", "É um fenômeno que mantém o calor dentro da Terra."],
	#"Reflorestamento": ["Ação de plantar árvores.", "Ajuda a restaurar áreas devastadas.", "Envolve replantar árvores em áreas desmatadas."],
	"Sustentabilidade": ["Conceito de usar recursos sem prejudicar o futuro.", "Busca um equilíbrio ambiental.", "Refere-se à manutenção da qualidade do meio ambiente."],
	"Aquecimento Global": ["Está ligado ao aumento da temperatura no planeta.", "Acontece por causa da poluição e desmatamento.", "É o aumento da temperatura média da Terra."],
}

var curMission
var misCompleted = 0

@onready var label = $HUD/Label
@onready var label_dica = $HUD/Label_Dica # Label para exibir a dica
@onready var timer_dica = $HUD/Timer_Dica  # Timer para ativar a dica

# controle de tempo e dicas
@onready var timer_progress = $HUD/TextureProgressBar
@onready var timer = $HUD/TextureProgressBar/Timer

# Índice para controlar qual dica está sendo exibida
var dica_index = -1
var dica_firstTime = false

func _ready():	
	# escolher a palavra aleatória
	rw = _random_word(word)
	label.text = str(rw)
	
	Dialogic.VAR.set('password', rw)
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Main.missionCompleted.connect(_mission_completed)
	
	_fademission("Talvez conversar com a IA irá te ajudar.")
	
	# animação de fogo
	$Scenes_Objects/Sala_Objects/Tv/AnimationPlayer.play("fogo")

	## Exibir a primeira dica no início do jogo
	#_exibir_dica()
	
	# Iniciar o timer para as dicas
	timer_dica.wait_time = 10  # tempo antes de mostrar a dica
	timer_dica.start()

# Função para exibir a dica atual
func _exibir_dica():
	var player = $HUD/AnimationPlayer
	
	if dica_firstTime == false:
		player.play('appear')
		dica_firstTime = true
	else:
		player.play("change_dica")
		await get_tree().create_timer(0.5).timeout
		
	if rw in dicas and dica_index < dicas[rw].size():
		label_dica.text = str(dicas[rw][dica_index])
		print("Dica mostrada: " + dicas[rw][dica_index])  # Mensagem de debug
	else:
		label_dica.text = ""

# Função chamada quando o timer expira
func _on_Timer_Dica_timeout():
	print("Timer Dica ativado")  # Mensagem de debug
	#_exibir_dica()  # Exibir a dica novamente
	timer_dica.start()  # Reiniciar o timer para a próxima dica

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
		fade_out($Scenes_Objects/Banheiro_Objects, 0.3, null)
		fade_out($Scenes_Objects/Quarto_Objects, 0.3, null)
		
		if Main.comodID != 1:
			fade_out($Scenes_Objects/Sala_Objects, 0.3, null)

func _on_dialogic_signal(argument:String):
	match argument:
		"conseguiu":
			print("acerto")
		"mission1":
			curMission = 1
			
			if $Scenes_Objects/Banheiro_Objects/Pia/InteractionArea != null:
				$Scenes_Objects/Banheiro_Objects/Pia/InteractionArea.can_interact = true
				
			$Scenes_Objects/Banheiro_Objects/Pia/AnimationPlayer.play("leak")
		"mission2":
			curMission = 2
			
			if $Scenes_Objects/Banheiro_Objects/Banheira/InteractionArea != null:
				$Scenes_Objects/Banheiro_Objects/Banheira/InteractionArea.can_interact = true
			
			$Scenes_Objects/Banheiro_Objects/Banheira/AnimationPlayer.play("leak")
		"mission3":
			curMission = 3
			
			if $Scenes_Objects/Cozinha_Objects/Lixeira/InteractionArea != null:
				$Scenes_Objects/Cozinha_Objects/Lixeira/InteractionArea.can_interact = true
		"mission4":
			curMission = 4
	
	# Resetar o timer da dica quando a missão mudar
	timer_dica.start()

func _mission_completed():
	misCompleted = curMission  # Corrigir a atribuição aqui
	
	# Atualizar a dica para a próxima mais clara
	dica_index += 1
	_exibir_dica()
	
	_fademission("Você deveria falar com a IA novamente.")
	
	if misCompleted == 1:
		Main.iaTalk = 1
	elif misCompleted == 2:
		Main.iaTalk = 2
	elif misCompleted == 3:
		Main.iaTalk = 3

func _end_game():
	print("O jogo acabou! Parabéns por completar todas as missões!")
	get_tree().change_scene_to_file("res://caminho/para/seu/menu_principal.tscn")  # Altere para o caminho correto do seu menu principal

func _fademission(text: String):
	var mission = $"HUD/Missão"
	mission.text = text
	
	await get_tree().create_timer(0.5).timeout
	fade_in(mission, 0.5)
	await get_tree().create_timer(2).timeout
	fade_out(mission, 0.5, Color.TRANSPARENT)

func _random_word(word):
	var w = randi() % len(word)
	var out = word[w]
	return out

func _random_mission(i, f):
	var rm = RandomNumberGenerator.new()
	var mrn = rm.randi_range(i, f)
	curMission = mrn

func fade_in(node, fade_duration):
	var fade_tween
	fade_tween = get_tree().create_tween()
	fade_tween.tween_property(node, "modulate", Color.WHITE, fade_duration)

func fade_out(node, fade_duration, color):
	if color == null: color = Color.BLACK
	var fade_tween
	fade_tween = get_tree().create_tween()
	fade_tween.tween_property(node, "modulate", color, fade_duration)

func _on_timer_timeout() -> void:
	timer_progress.value += 1
