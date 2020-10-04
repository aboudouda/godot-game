extends VBoxContainer

signal close_pausescreen

func _on_NewGameButton_pressed():
	get_tree().change_scene('res://main/World.tscn')


func _on_Continue2Button_pressed():
	emit_signal("close_pausescreen")


func _on_OptionsButton_pressed():
	pass # Replace with function body.


func _on_RetryButton_pressed():
	get_tree().change_scene('res://main/World.tscn')


func _on_QuitButton_pressed():
	get_tree().change_scene('res://menu/Titlescreen.tscn')


func _on_ContinueButton_pressed():
	pass # Replace with function body.