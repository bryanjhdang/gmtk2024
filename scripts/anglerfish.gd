extends "res://scripts/fish.gd"
#
func _shoot():
	print("shooting lighting bolts")
	print(super().projectile)
	#var speed: float = 1000
	#var max_range: float = 1000
	#var p = projectile.instantiate()
	##var p: Projectile = Projectile.get_projectile(speed, max_range, 0)
	#get_parent().add_child(p)
	##p.transform = $ProjectileEmitter.global_transform
