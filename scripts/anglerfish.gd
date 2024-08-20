extends "res://scripts/fish.gd"

const projectile: PackedScene = preload("res://projectiles/projectile-bolt.tscn")

func _shoot():
	var p_1 = projectile.instantiate()
	var p_2 = projectile.instantiate()

	
	get_parent().add_child(p_1)
	get_parent().add_child(p_2)
	p_1.transform = $"angler-emiter-1".global_transform
	p_2.transform = $"angler-emiter-2".global_transform
