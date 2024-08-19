extends Node2D

var enemy = preload("res://characters/enemy/enemy.tscn")
var num_enemies_spawned: int = 0


func _on_timer_timeout():
	var enemy_to_spawn = Enemy.new_enemy("", 1.0, 1.0, 100)
	
	# TODO spawn enemy within world boundaries
	var x = randf_range(20, 1000)
	var y = randf_range(20, 1000)
	enemy_to_spawn.position = Vector2(x, y)
	add_child(enemy_to_spawn)
	num_enemies_spawned += 1
