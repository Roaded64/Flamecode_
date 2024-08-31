extends Node

var item_data = {}
var data_file_path = "res://assets/json/items.json"

func _ready() -> void:
	item_data = load_json_file()

func change_json_file(item):
	item_data[item]["is_taken"] = true

func load_json_file():
	if FileAccess.file_exists(data_file_path):
		var data_file = FileAccess.open(data_file_path, FileAccess.READ)
		var parsed_result = JSON.parse_string(data_file.get_as_text())
		
		if parsed_result is Dictionary:
			return parsed_result
		else:
			print("Erro ao achar o arquivo json.")
	else:
		print("O arquivo não existe.")
