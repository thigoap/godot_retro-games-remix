extends Node2D

@onready var interaction_area = $InteractionArea
@onready var sprite_2d = $Sprite2D

@onready var animation_player = $AnimationPlayer
@onready var player_manager = $"../Player Manager"
@onready var p01_inv: Inv = preload('res://Inventory/player01_inventory.tres')
@onready var p02_inv: Inv = preload('res://Inventory/player02_inventory.tres')

var opened = false
var locked = true

func _ready():
	interaction_area.interact = Callable(self, "_open")
	
func _open():
	# sprite_2d.frame = 2 if sprite_2d.frame == 0 else 0
	if (!opened):
		var has_key = _has_key()
		if has_key or !locked:
			animation_player.play("door_open")
			opened = true
			locked = false
		else:
			print('player does not have the key')
	else:
		animation_player.play("door_close")
		opened = false

func _has_key():
	for i in range (3):
		var inventory_slot
		if player_manager.player:
			inventory_slot = p01_inv.slots[i].item
		else:
			inventory_slot = p02_inv.slots[i].item
		if inventory_slot && inventory_slot.name == 'key':
			return true
	return false
