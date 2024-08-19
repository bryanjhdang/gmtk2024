extends Node2D

# @onready var game_manager: Node = owner.get_node("GameManager")
var enemy = preload("res://characters/enemy/enemy.tscn")
var num_enemies_spawned: int = 0


# TESTING
var enemy_types: Array = ["fish-enemy.png", "fish-cooked-svgrepo-com.svg", "puffer-fish.webp", "karp-fish.png"] 
var enemy_size_values: Array = [1, 5, 20, 50, 500]

# TODO refactor the following
func get_new_enemy(score: int = 100):		
	#var enemy = Enemy.enemy_factory()
	
	#enemy.speed = randf_range(1, 100)
	var type = randi_range(0, 3)
	var size = randi_range(0, 99) % 20
	var sprite = load(str("res://assets/", enemy_types[type]))
	
	#enemy.value = 100 * randf_range(0, 0.5) + 100
	#enemy.get_child(0).texture = sprite
	#return enemy
	pass


# TODO refactor
func _on_timer_timeout():
	#var enemy_to_spawn = get_new_enemy()
	
	# TODO spawn enemy outside of the camera, but on the edge of it?
	var x = randf_range(20, 1000)
	var y = randf_range(20, 1000)
	
	#enemy_to_spawn.position = Vector2(x, y)
	#add_child(enemy_to_spawn)
	#num_enemies_spawned += 1
	pass
