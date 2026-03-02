class_name DocumentationController
extends HTTPRequest

@onready var version = Engine.get_version_info()
@onready var file_location = $FileDialog
@onready var url = "https://github.com/godotengine/godot-docs/archive/refs/heads/"+str(version.major)+"."+str(version.minor)+".zip"

func _ready():
	#print(version.major)
	#print(version.minor)
	print(url)
	request_completed.connect(self._http_request_completed)
	# Make the request
	file_location.visible = true
		
func _http_request_completed(result, response_code, headers, body):
	print("downloaded")
	print(response_code)
	#unpack zip
	var zipreader = ZIPReader.new()
	zipreader.open(download_file)
	var files = zipreader.get_files()
	for file in files:
		print(file)
	#format files into new folder
	#var json = JSON.new()
	#json.parse(body.get_string_from_utf8())
	#var response = json.get_data()

func _on_file_dialog_dir_selected(dir: String) -> void:
	download_file = dir+"/download.zip"
	print(download_file)
	var error = OK#request(url)
	if error != OK:
		push_error("An error occurred in the HTTP request.")
	self._http_request_completed("",200,"","")


func _on_file_dialog_canceled() -> void:
	print("dialog_canceled")


func _on_file_dialog_confirmed() -> void:
	print("dialog_confirmed")


func _on_file_dialog_custom_action(action: StringName) -> void:
	print("custom_action")
