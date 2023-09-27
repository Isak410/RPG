extends Node


var player_current_attack = false


func respawn_enemy():
	print("enemy respawning")
	var new_enemy = preload("res://scenes/enemy.tscn").instantiate()
	new_enemy.position.x = 50
	new_enemy.position.y = 50
	get_parent().add_child(new_enemy)
