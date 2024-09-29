extends Node2D

@onready var interaction_area = $InteractionArea

func _ready() -> void:
	interaction_area.interact = Callable(self, "_talk")
	# Conecte o sinal ao método que habilitará o ScriptB

func _talk():
	if !Dialogic.is_playing:
		match Main.iaTalk:
			0:
				Dialogic.start("mission1_AItimeline")
			1:
				Dialogic.start("mission2_AItimeline")
			2:
				Dialogic.start("mission3_AItimeline")
			3:
				Dialogic.start("word_AItimeline")
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
