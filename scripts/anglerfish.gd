extends "res://scripts/fish.gd"

const projectile: PackedScene = preload("res://projectiles/projectile-bolt.tscn")

func _shoot():
	var p_1 = projectile.instantiate()
	var p_2 = projectile.instantiate()
	var p_3 = projectile.instantiate()
	
	p_1.transform = $"angler-emiter-1".global_transform
	p_2.transform = $"angler-emiter-2".global_transform
	p_3.transform = $"angler-emiter-3".global_transform
	
	p_1.speed = 4000
	p_2.speed = 4000
	p_3.speed = 4000
	
	p_1.rotation_degrees = -155
	p_2.rotation_degrees = 155
	
	get_parent().add_child(p_1)
	get_parent().add_child(p_2)
	get_parent().add_child(p_3)
