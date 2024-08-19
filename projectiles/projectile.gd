class_name Projectile
extends Area2D

@export var speed: int = 500
@export var max_range: float = 1000
var distance_traveled: float = 0.0

#const projectile: PackedScene = preload("res://projectiles/projectile.tscn")
#func get_projectile(speed: float, max_range: float) -> Projectile:
	#var p = projectile.instantiate()
	#p._speed = speed
	#p._max_range = max_range
	#return p

func _physics_process(delta: float) -> void:
	var distance: float = speed * delta
	var velocity: Vector2 = transform.x * speed * delta
	
	position += velocity
	distance_traveled += distance
	
	if distance_traveled > max_range:
		queue_free()

func _on_body_entered(body) -> void:
	body._damaged()
