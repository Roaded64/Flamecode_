extends Node2D

# palavras pra ir pra roda!
const word = ["amante", "a", "mulher", "negro", "escravo"]
var rw

@onready var label = $HUD/Label
@onready var test_box = $ColorRect

func _ready():
	# escolher a palavra aleatória
	rw = _random_word(word)
	
	#label.text += str(rw)
	#
	#Dialogic.VAR.set('need', rw)
	Dialogic.signal_event.connect(_on_dialogic_signal)
	
	# switch da vida
	#match rw:
		#"amante":
			#test_box.color = Color(1, 1, 1)
		#"a":
			#test_box.color = Color(0, 0, 0)
		#"mulher":
			#test_box.color = Color(1, 0, 0)
		#"negro":
			#test_box.color = Color(0, 1, 0)
		#"escravo":
			#test_box.color = Color(0, 0, 1)

func _on_dialogic_signal(argument:String):
	if argument == "conseguiu":
		print("acerto")

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
