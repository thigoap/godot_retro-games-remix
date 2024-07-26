extends Node

@onready var players_games = $"MarginContainer/VBoxContainer/VBoxContainer2/GridContainer/Players Games"
@onready var player_1_victories = $"MarginContainer/VBoxContainer/VBoxContainer2/GridContainer/Player 1 Victories"
@onready var player_2_victories = $"MarginContainer/VBoxContainer/VBoxContainer2/GridContainer/Player 2 Victories"
@onready var players_draws = $"MarginContainer/VBoxContainer/VBoxContainer2/GridContainer/Players Draws"


func _ready():
	update_status()


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_clear_button_pressed():
	Status.clear_status()
	update_status()
	

func update_status():
	players_games.text = str(Status.players_games)
	player_1_victories.text = str(Status.player_1_victories)
	player_2_victories.text = str(Status.player_2_victories)
	players_draws.text = str(Status.players_draws)	
