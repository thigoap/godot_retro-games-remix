extends Node

@export var circle_scene : PackedScene
@export var cross_scene : PackedScene
@export var circle_marker_scene : PackedScene
@export var cross_marker_scene : PackedScene

@onready var board = $CenterContainer/VBoxContainer

var player : int
var moves : int
var winner : int
var temp_marker
var player_panel_pos : Vector2i
var grid_data : Array
var grid_pos : Vector2i
var board_size : int
var board_pos : Vector2i
var cell_size : int
var row_sum : int
var col_sum : int
var diagonal1_sum : int
var diagonal2_sum : int


# Called when the node enters the scene tree for the first time.
func _ready():
	board_size = $CenterContainer/VBoxContainer/BoardTextureRect.texture.get_width()
	# divide board size by 3 to get the size of individual cell
	cell_size = board_size / 3
	new_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if check_if_inside_board(event):
				#convert mouse position into grid location
				grid_pos = Vector2i((Vector2i(event.position) - board_pos) / cell_size)
				if grid_data[grid_pos.y][grid_pos.x] == 0:
					moves += 1
					grid_data[grid_pos.y][grid_pos.x] = player
					#place that player's marker
					create_marker(player, grid_pos * cell_size + Vector2i(cell_size / 2, cell_size / 2))
					if check_win(player) != 0:
						get_tree().paused = true
						$CenterContainer/GameOverMenu.show()
						if winner == 1:
							$CenterContainer/GameOverMenu.get_node("ResultLabel").text = "Player 1 Wins!"
						elif winner == -1:
							$CenterContainer/GameOverMenu.get_node("ResultLabel").text = "Player 2 Wins!"
					#check if the board has been filled
					elif moves == 9:
						player = 0
						change_bg_color(player)
						get_tree().paused = true
						$CenterContainer/GameOverMenu.show()
						$CenterContainer/GameOverMenu.get_node("ResultLabel").text = "It's a Tie!"
					player *= -1
					
					
					#update the panel marker
					#temp_marker.queue_free()
					# player_panel_pos = $CenterContainer/VBoxContainer/HBoxContainer/PlayerPanel.get_position()
					# create_marker(player, player_panel_pos + Vector2i(cell_size / 4, cell_size / 4), true)
					print(grid_data)


func check_if_inside_board(event):
	# check board position (offsets)
	if !board_pos:
		board_pos = board.get_position()
	# check if mouse is on the game board
	if event.position.y > board.position.y && \
	event.position.y < board.position.y + board_size && \
	event.position.x > board.position.x && \
	event.position.x < board.position.x + board_size:
		return true
	return false

func new_game():
	player = 1
	moves = 0
	winner = 0
	grid_data = [
		[0, 0, 0],
		[0, 0, 0],
		[0, 0, 0]
		]
	row_sum = 0
	col_sum = 0
	diagonal1_sum = 0
	diagonal2_sum = 0
	#clear existing markers
	get_tree().call_group("circles", "queue_free")
	get_tree().call_group("crosses", "queue_free")
	#create a marker to show starting player's turn
	#create_marker(player, player_panel_pos + Vector2i(cell_size / 4, cell_size / 4), true)
	$CenterContainer/GameOverMenu.hide()
	get_tree().paused = false
	change_bg_color(player)


func create_marker(player, position, temp=false):
	#create a marker node and add it as a child
	if player == 1:
		#if temp: 
		#	var circle = circle_marker_scene.instantiate()
		#	circle.position = position
		#	add_child(circle)
		#	temp_marker = circle
		#else:
		var circle = circle_scene.instantiate()
		circle.position = position + board_pos
		add_child(circle)
	else:
		#if temp: 
		#	var cross = cross_marker_scene.instantiate()
		#	cross.position = position
		#	add_child(cross)
		#	temp_marker = cross
		#else:
		var cross = cross_scene.instantiate()
		cross.position = position + board_pos
		add_child(cross)


func check_win(player):
	#add up the markers in each ros, column and diagonal
	for i in len(grid_data):
		row_sum = grid_data[i][0] + grid_data[i][1] + grid_data[i][2]
		col_sum = grid_data[0][i] + grid_data[1][i] + grid_data[2][i]
		diagonal1_sum = grid_data[0][0] + grid_data[1][1] + grid_data[2][2]
		diagonal2_sum = grid_data[0][2] + grid_data[1][1] + grid_data[2][0]
	
		#check if either player has all of the markers in one line
		if row_sum == 3 or col_sum == 3 or diagonal1_sum == 3 or diagonal2_sum == 3:
			winner = 1
		elif row_sum == -3 or col_sum == -3 or diagonal1_sum == -3 or diagonal2_sum == -3:
			winner = -1
	if winner == 0:
		change_bg_color(player * -1)
	return winner


func _on_game_over_menu_restart():
	new_game()


func change_bg_color(player):
	var style:StyleBoxFlat = StyleBoxFlat.new()
	if player == 1:
		style.bg_color =  Color(255,0,0)
	if player == -1:
		style.bg_color =  Color(0,0,255)
	if player == 0:
		style.bg_color =  Color(100,100,100)
	
	style.bg_color.a = 0.5
	$Panel.add_theme_stylebox_override ("panel", style)


func _on_button_pressed():
	new_game()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
