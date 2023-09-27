extends Node


var player_current_attack = false


func respawn_enemy():
	print("enemy respawning")
	var new_enemy = preload("res://scenes/enemy.tscn").instantiate()
	add_child(new_enemy)
