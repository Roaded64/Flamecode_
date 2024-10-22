extends Node2D

@onready var interaction_area = $InteractionArea
var am = 0

func _ready() -> void:
	interaction_area.interact = Callable(self, "_talk")
	Main.missionCompleted.connect(_mission_completed)
	Dialogic.signal_event.connect(_on_dialogic_signal)
	# Conecte o sinal ao método que habilitará o ScriptB

func _process(delta: float) -> void:
	if am == 0:
		$aiTalk.visible = true
		$aiTalk.play("default")
	else:
		$aiTalk.visible = false

func _talk():
	if !Dialogic.is_playing:
		if am == 0:
			match Main.iaTalk:
				0:
					Dialogic.start("mission1_AItimeline")
				1:
					Dialogic.start("mission2_AItimeline")
				2:
					Dialogic.start("mission3_AItimeline")
				3:
					Dialogic.start("word_AItimeline")
		elif am == 1:
			Dialogic.start("missionNot_AItimeline")
	#Main._random_mission()
	#
	#match Main.mission:
		#1:
			#if !Dialogic.is_playing:
				#Dialogic.start("mission1_AItimeline")
			#Main.missionAtual = 1
		#2:
			#if !Dialogic.is_playing:
				#Dialogic.start("mission2_AItimeline")
			#Main.missionAtual = 2
		#3:
			#if !Dialogic.is_playing:
				#Dialogic.start("mission3_AItimeline")
			#Main.missionAtual = 4
		#4:
			#if !Dialogic.is_playing:
				#Dialogic.start("mission4_AItimeline")
		#5:
			#if !Dialogic.is_playing:
				#Dialogic.start("mission5_AItimeline")

	#if !Dialogic.is_playing:
	#    Dialogic.start("ia_timeline")
	#else:
	#    pass

func _mission_completed():
	am = 0

func _on_dialogic_signal(argument: String):
	if argument == "mission1" || argument == "mission2" || argument == "mission3":
			am = 1
