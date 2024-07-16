extends Area2D

@onready var death_timer = $Timer
@onready var collision_shape = $CollisionShape2D

const SPEED = 100

func _process(delta):
	position.x += SPEED * delta


func _on_area_entered(area):
	death_timer.start()


func _on_timer_timeout():
	hit()


func check_player():
	print('check')
	var players = get_tree().get_nodes_in_group("player")
	for player in players:
		if player.get_node("PlayerSprite2D").global_position == collision_shape.global_position:
			death_timer.start()

func hit():
	#get_tree().reload_current_scene()
	print('died')