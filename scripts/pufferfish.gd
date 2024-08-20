extends "res://scripts/fish.gd"

const projectile: PackedScene = preload("res://projectiles/projectile-spike.tscn")

func _shoot():
	var p_1 = projectile.instantiate()
	var p_2 = projectile.instantiate()
	var p_3 = projectile.instantiate()
	var p_4 = projectile.instantiate()
	
	p_1.transform = $"puffer-emitter-1".global_transform
	p_2.transform = $"puffer-emitter-2".global_transform
	p_3.transform = $"puffer-emitter-3".global_transform
	p_4.transform = $"puffer-emitter-4".global_transform
	
	p_1.speed = 3500
	p_2.speed = 3500
	p_3.speed = 3500
	p_4.speed = 3500
	
	p_1.rotation_degrees = 225
	p_2.rotation_degrees = -45
	p_3.rotation_degrees = -225
	p_4.rotation_degrees = 45
	
	get_parent().add_child(p_1)
	get_parent().add_child(p_2)
	get_parent().add_child(p_3)
	get_parent().add_child(p_4)
	
	
