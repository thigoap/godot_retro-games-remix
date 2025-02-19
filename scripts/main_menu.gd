extends Control

func _ready():
	Status.load_status()
	
func _on_tic_tac_toe_pressed():
	get_tree().change_scene_to_file("res://scenes/tic tac toe/tic_tac_toe.tscn")

func _on_credits_pressed():
	get_tree().change_scene_to_file("res://scenes/credits.tscn")

func _on_statistics_pressed():
	get_tree().change_scene_to_file("res://scenes/statistics.tscn")
	
func _on_quit_pressed():
	get_tree().quit()
