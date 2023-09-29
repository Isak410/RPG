extends Node2D
var new_enemy = preload("res://scenes/enemy.tscn")

var spawnpos1

func respawn_enemy():
	var test = $TileMap/Node.get_child_count()
	print(test)
	#print(spawnposition)

	print("enemy respawning")
	new_enemy.instantiate()
	new_enemy.position = spawnpos1.position
	#new_enemy.position.x = 50
	#new_enemy.position.y = 50
	$TileMap.add_child(new_enemy)
	
func _on_enemyrespawntimer_timeout():
	respawn_enemy()
	$enemyrespawntimer.start()
	print("enemy respawned")



# Called when the node enters the scene tree for the first time.
func _ready():
	$enemyrespawntimer.start()
	spawnpos1 = $TileMap/Node/spawnpos1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



