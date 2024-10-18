extends Node2D

# palavras para as missões
const word = ["IA", "Sustentabilidade", "Aquecimento Global"]
var rw
var dica

# múltiplas dicas associadas às palavras (em diferentes níveis de clareza)
const dicas = {
	"IA": ["Refere-se à criação de máquinas que podem 'pensar'.", "É usada em muitos campos, incluindo tecnologia.", "É uma abreviação de Inteligência Artificial."],
	"Sustentabilidade": ["Conceito de usar recursos sem prejudicar o futuro.", "Busca um equilíbrio ambiental.", "Refere-se à manutenção da qualidade do meio ambiente."],
	"Aquecimento Global": ["Está ligado ao aumento da temperatura no planeta.", "Acontece por causa da poluição e desmatamento.", "É o aumento da temperatura média da Terra."],
}

var curMission = 0
var rMission = 0
var misCompleted = 0
var used = false

@onready var label = $HUD/Label
@onready var label_dica = $HUD/Label_Dica # Label para exibir a dica
@onready var timer_dica = $HUD/Timer_Dica  # Timer para ativar a dica

# controle de tempo e dicas
@onready var timer_progress = $HUD/TextureProgressBar
@onready var timer = $HUD/TextureProgressBar/Timer

# Índice para controlar qual dica está sendo exibida
var dica_index = -1
var dica_firstTime = false

# Referências para os Sprites dos fogos
#@onready var fogo_banheiro = $Scenes_Objects/Fogo_banheiro
#@onready var fogo_quarto = $Scenes_Objects/Fogo_quarto
#@onready var fogo_porta = $Scenes_Objects/Fogo_porta
#@onready var fogo_aux = $Scenes_Objects/Fogo_aux  # Novo fogo auxiliar

var i: int

func _ready():	
	# escolher a palavra aleatória
	rw = _random_word(word)
	label.text = str(rw)
	
	Dialogic.VAR.set('password', rw)
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Main.missionCompleted.connect(_mission_completed)
	Main.useThing.connect(_used)
	
	_fademission("Talvez conversar com a IA irá te ajudar.")
	
	# animação de fogo
	$Scenes_Objects/Sala_Objects/Tv/AnimationPlayer.play("fogo")

	# Iniciar o estado inicial dos fogos
	#_iniciar_fogos()

	# Iniciar o timer para as dicas
	timer_dica.wait_time = 10  # tempo antes de mostrar a dica
	timer_dica.start()

# Função para iniciar o estado inicial dos fogos
#func _iniciar_fogos():
	## Configurações iniciais dos fogos
	#fogo_banheiro.visible = false  # Fogo do banheiro começa invisível
	#fogo_quarto.visible = true  # Fogo do quarto começa visível
	#fogo_porta.visible = true  # Fogo da porta começa visível
	#fogo_aux.visible = true  # Fogo auxiliar começa visível

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

	if Main.comodID == 1:
		fade_in($Scenes_Objects/Sala_Objects, 0.4)
		fade_in($Scenes_Objects/Cozinha_Objects, 0.4)
	elif Main.comodID != 1:
		fade_out($Scenes_Objects/Sala_Objects, 0.3, Color(0.071, 0.071, 0.071))
		fade_out($Scenes_Objects/Cozinha_Objects, 0.3, Color(0.071, 0.071, 0.071))
		
	if Main.comodID == 2:
		fade_in($Scenes_Objects/Banheiro_Objects, 0.4)
	elif Main.comodID == 3:
		fade_in($Scenes_Objects/Quarto_Objects, 0.4)
	#elif Main.comodID == 4:
		#fade_in($Scenes_Objects/Lavanderia_Objects, 0.4)
	else:
		fade_out($Scenes_Objects/Banheiro_Objects, 0.3, Color(0.071, 0.071, 0.071))
		fade_out($Scenes_Objects/Quarto_Objects, 0.3, Color(0.071, 0.071, 0.071))
		#fade_out($Scenes_Objects/Lavanderia_Objects, 0.3, Color(0.071, 0.071, 0.071))
	
	if curMission == 1 || curMission == 2:
		if i == 6:
			_fademission("Apague o fogo e volte para a torneira.")
			await get_tree().create_timer(1).timeout
			i = 7
		elif i == 9:
			if Main.comodID == 1:
				$Scenes_Objects/Player/CharacterBody2D/Camera2D.apply_shake()
				$Scenes_Objects/Fogos/FogoBanheiro.is_active = true
				$Scenes_Objects/Fogos/FogoBanheiro/PointLight2D5.visible = true
				await get_tree().create_timer(0.5).timeout
				i = 0

func _on_dialogic_signal(argument:String):
	match argument:
		"conseguiu":
			print("acerto")
		"mission1":
			if curMission == 0:
				_random_mission(1, 2)
			
			if rMission == 1:
				curMission = 1
				
				if $Scenes_Objects/Banheiro_Objects/Pia/InteractionArea != null:
					$Scenes_Objects/Banheiro_Objects/Pia/InteractionArea.can_interact = true
					
				$Scenes_Objects/Banheiro_Objects/Pia/AnimationPlayer.play("leak")
			elif rMission == 2:
				curMission = 2
			
				if $Scenes_Objects/Banheiro_Objects/Banheira/InteractionArea != null:
					$Scenes_Objects/Banheiro_Objects/Banheira/InteractionArea.can_interact = true
				
				$Scenes_Objects/Banheiro_Objects/Banheira/AnimationPlayer.play("leak")
		"mission2":
			pass
			
		"mission3":
			curMission = 3
			
			if $Scenes_Objects/Cozinha_Objects/Lixeira/InteractionArea != null:
				$Scenes_Objects/Cozinha_Objects/Lixeira/InteractionArea.can_interact = true
			
			# Quando a missão 3 é completada, ativar o fogo do banheiro
			#fogo_banheiro.visible = true
		
		"mission4":
			curMission = 4
			
			if $Scenes_Objects/Cozinha_Objects/Lixeira/InteractionArea != null:
				$Scenes_Objects/Cozinha_Objects/Lixeira/InteractionArea.can_interact = true
	
	# Resetar o timer da dica quando a missão mudar
	timer_dica.start()

func _mission_completed():
	i = 9
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
		
		# Após a missão 3, fazer todos os fogos desaparecerem
		#await get_tree().create_timer(2.0).timeout  # Tempo de 2 segundos
		#_desativar_fogos()

## Função para desativar todos os fogos
#func _desativar_fogos():
	#fogo_banheiro.visible = false
	#fogo_quarto.visible = false
	#fogo_porta.visible = false
	#fogo_aux.visible = false  # Desativar também o fogo auxiliar

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
	rMission = mrn

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
	timer.start()


func _on_area_2d_body_entered(body):
	pass # Replace with function body.


func _on_collision_shape_2d_tree_entered():
	pass # Replace with function body.

func _used():
	if curMission == 1 || curMission == 2:
		$Scenes_Objects/Fogos/FogoBanheiro/GPUParticles2D.emitting = true
		$Scenes_Objects/Fogos/FogoBanheiro.is_active = false
		$Scenes_Objects/Fogos/FogoBanheiro/PointLight2D5.visible = false
			
		if i <= 4 || i == 7:
			if i != 7:
				await get_tree().create_timer(0.7).timeout
				$Scenes_Objects/Player/CharacterBody2D/Camera2D.apply_shake()
				$Scenes_Objects/Fogos/FogoBanheiro.is_active = true
				$Scenes_Objects/Fogos/FogoBanheiro/PointLight2D5.visible = true
				i += 1
				
			if i == 4:
				i = 6
			elif i == 7:
				i = 8
