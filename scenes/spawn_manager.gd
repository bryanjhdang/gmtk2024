extends Node2D

var enemy = preload("res://characters/enemy/enemy.tscn")

func _on_timer_timeout():
	var x = randf_range(20, 1000)
	var y = randf_range(20, 1000)
	var enemy_to_spawn = Enemy.new_enemy("", 1.0, 1.0, 100)
	enemy_to_spawn.position = Vector2(x, y)
	add_child(enemy_to_spawn)
