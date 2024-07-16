extends Node2D

@onready var interaction_area = $InteractionArea
@onready var sprite_2d = $Sprite2D

@onready var animation_player = $AnimationPlayer
@onready var player_manager = $"../Player Manager"
@onready var p01_inv = $"../Player01/Player Inventory"
@onready var p02_inv = $"../Player02/Player Inventory"

@export var loot:InvItem
@export var locked:bool
var opened = false
var has_loot = true

func _ready():
	interaction_area.interact = Callable(self, "_open_close")
	
func _open_close():
	if (!opened):
		animation_player.play("chest_open")
		opened = true
		if player_manager.player && has_loot:
			p01_inv.collect(loot)
		elif !player_manager.player && has_loot:
			p02_inv.collect(loot)
		has_loot = false
	else:
		animation_player.play("chest_close")
		opened = false
