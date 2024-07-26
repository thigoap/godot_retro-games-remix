extends Node

var save_path = "user://variable.save"

var players_games: int
var player_1_victories: int
var player_2_victories: int
var players_draws: int
var easy_bot_games: int
var medium_bot_games: int
var easy_player_victories: int
var medium_player_victories: int
var easy_bot_victories: int
var medium_bot_victories: int
var easy_draws: int
var medium_draws: int

func save_status():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(players_games)
	file.store_var(player_1_victories)
	file.store_var(player_2_victories)
	file.store_var(players_draws)

func load_status():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		players_games = file.get_var()
		player_1_victories = file.get_var()
		player_2_victories = file.get_var()
		players_draws = file.get_var()
	else:
		clear_status()

func clear_status():
	players_games = 0
	player_1_victories = 0
	player_2_victories = 0
	players_draws = 0
	easy_bot_games = 0
	medium_bot_games = 0
	easy_player_victories = 0
	medium_player_victories = 0
	easy_bot_victories = 0
	medium_bot_victories = 0
	easy_draws = 0
	medium_draws = 0
	save_status()
