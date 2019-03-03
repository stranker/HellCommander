extends Control

var _player_name = ""
var serverIP = ""

func _on_TextField_text_changed(new_text):
	_player_name = new_text

func _on_CreateButton_pressed():
	if _player_name == "":
		return
	Network.create_server(_player_name)
	_load_game()

func _on_JoinButton_pressed():
	if _player_name == "":
		return
	$Panel/ClientPanel.show()
	
func _load_game():
	get_tree().change_scene('res://Scenes/TestScene.tscn')

func _on_CloseButton_pressed():
	$Panel/ClientPanel.hide()
	pass # replace with function body


func _on_ConnectButton_button_down():
	if serverIP == "":
		return
	Network.connect_to_server(_player_name, serverIP)
	_load_game()
	pass # replace with function body

func _on_IPServer_text_changed(new_text):
	serverIP = new_text
	pass # replace with function body