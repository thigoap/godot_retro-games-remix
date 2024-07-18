extends CanvasLayer

signal restart

func _on_restart_button_pressed():
	get_tree().paused = false
	restart.emit()


func _on_main_menu_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
