extends Control


func _on_tic_tac_toe_pressed():
	get_tree().change_scene_to_file("res://scenes/tic tac toe/tic_tac_toe.tscn")


func _on_credits_pressed():
	get_tree().change_scene_to_file("res://scenes/credits.tscn")


func _on_quit_pressed():
	get_tree().quit()


