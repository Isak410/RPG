extends Node2D
var new_enemy = preload("res://scenes/enemy.tscn")


func respawn_enemy():
	var my_array = [$TileMap/Node/spawnpos1, $TileMap/Node/spawnpos2, $TileMap/Node/spawnpos3]
	var rand_value = my_array[randi() % my_array.size()]
	var enemy1 = new_enemy.instantiate()
	print("enemy respawning")
	enemy1.position = rand_value.position
	$TileMap.add_child(enemy1)
	
func _on_enemyrespawntimer_timeout():
	respawn_enemy()
	$enemyrespawntimer.start()
	print("enemy respawned")


# Called when the node enters the scene tree for the first time.
func _ready():
	$enemyrespawntimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
