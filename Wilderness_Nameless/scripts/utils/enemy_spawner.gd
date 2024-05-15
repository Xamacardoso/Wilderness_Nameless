extends Node2D

@export var spawns : Array[SpawnInfo] = []
@onready var player = get_tree().get_first_node_in_group("player")

var time=0



## Spawns enemy when time is out
func _on_timer_timeout():
	time += 1
	
	# picks an enemy from the resource
	var enemy_spawns = spawns
	
	# handles enemy spawn
	for enem in enemy_spawns:
		if time >= enem.time_start and time <= enem.time_end: # if is between the time start and end
			if enem.spawn_delay_counter < enem.enemy_spawn_delay: # checks if it has delay
				enem.spawn_delay_counter += 1
			else:
				enem.spawn_delay_counter = 0
				var new_enemy = enem.enemy
				var counter = 0
				while counter < enem.enemy_num: # spawn the number of enemies setted
					var enemy_spawn = new_enemy.instantiate() # creates spawn instance
					enemy_spawn.global_position = get_random_position()
					add_child(enemy_spawn) # adds the instance of the enemy to the enemy spawner NODE
					counter+=1 # increases the counter for every enemy spawned, until it reaches the enemy spawn number

## Gets a random position for the enemy to spawn
func get_random_position():
	# viewport size and a bit further
	var vpr = get_viewport_rect().size * randf_range(1.1,1.4)
	
	# get the corners
	var top_left = Vector2(player.global_position.x - vpr.x/2 , player.global_position.y - vpr.y/2)
	var top_right = Vector2(player.global_position.x + vpr.x/2 , player.global_position.y - vpr.y/2)
	var bottom_left = Vector2(player.global_position.x - vpr.x/2 , player.global_position.y + vpr.y/2)
	var bottom_right = Vector2(player.global_position.x + vpr.x/2 , player.global_position.y + vpr.y/2)
	
	# random side to the enemy to spawn
	var pos_side = ["up","down","left","right"].pick_random()
	
	# vectorizes the spawn position
	var spawn_pos1 = Vector2.ZERO
	var spawn_pos2 = Vector2.ZERO
	
	# matches the position side and assigns it to the spawn position
	match pos_side:
		"up":
			spawn_pos1 = top_left
			spawn_pos2 = top_right
		"down":
			spawn_pos1 = bottom_left
			spawn_pos2 = bottom_right
		"right":
			spawn_pos1 = top_right
			spawn_pos2 = bottom_right
		"left":
			spawn_pos1 = top_left
			spawn_pos2 = bottom_left
	
	# picks a random coordinate of the side to spawn the enemy
	var x_spawn = randf_range(spawn_pos1.x , spawn_pos2.x)
	var y_spawn = randf_range(spawn_pos1.y , spawn_pos2.y)
	
	# returns the enemy spawn position
	return Vector2(x_spawn, y_spawn)
