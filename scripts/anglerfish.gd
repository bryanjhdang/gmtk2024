extends "res://scripts/fish.gd"

const projectile: PackedScene = preload("res://projectiles/projectile-bolt.tscn")

const angler_bullet_speed = 3000
const angler_bullet_rotation_left = 155
const angler_bullet_rotation_right = 335

func _shoot():
	var p_1 = projectile.instantiate()
	var p_2 = projectile.instantiate()
	var p_3 = projectile.instantiate()
	
	p_1.transform = $"angler-emiter-1".global_transform
	p_2.transform = $"angler-emiter-2".global_transform
	p_3.transform = $"angler-emiter-3".global_transform
	
	p_1.speed = angler_bullet_speed
	p_2.speed = angler_bullet_speed
	p_3.speed = angler_bullet_speed
	
	
	if scale.x > 0: # Facing Right
		p_1.rotation_degrees = angler_bullet_rotation_right
		p_2.rotation_degrees = -angler_bullet_rotation_right
	else: # Facing left 
		p_1.rotation_degrees = -angler_bullet_rotation_left
		p_2.rotation_degrees = angler_bullet_rotation_left
	
	get_parent().add_child(p_1)
	get_parent().add_child(p_2)
	get_parent().add_child(p_3)
