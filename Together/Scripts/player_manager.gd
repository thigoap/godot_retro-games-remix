extends Node

var player = true
@onready var player_movement_01 = $"../Player01/PlayerMovement"
@onready var player_movement_02 = $"../Player02/PlayerMovement"
@onready var player_actions_01 = $"../Player01/PlayerActions"
@onready var player_actions_02 = $"../Player02/PlayerActions"


# Called when the node enters the scene tree for the first time.
func _ready():
	player_movement_01.set_process(player)
	player_movement_01.set_physics_process(player)
	player_movement_02.set_process(!player)
	player_movement_02.set_physics_process(!player)
	player_actions_01.set_process(player)
	player_actions_01.set_physics_process(player)
	player_actions_02.set_process(!player)
	player_actions_02.set_physics_process(!player)
	
	print('player 01') if player else print('player 02')

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta):
	if Input.is_action_just_pressed("swap"):
		swapPlayer()
	
func swapPlayer():
	player = !player
	player_movement_01.set_process(player)
	player_movement_01.set_physics_process(player)
	player_movement_02.set_process(!player)
	player_movement_02.set_physics_process(!player)
	player_actions_01.set_process(player)
	player_actions_01.set_physics_process(player)
	player_actions_02.set_process(!player)
	player_actions_02.set_physics_process(!player)
	print('player 01') if player else print('player 02')
