extends Area2D

@onready var game_manager: Node = get_node("../../GameManager")
@onready var spawn_manager: Node2D = get_parent()

@export var enemy: PackedScene 
@export var projectile: PackedScene

@export var value: float = 1
@export var speed: float = 1

#static func enemy_factory() -> Enemy:
	#return enemy.instantiate()

func _on_body_entered(body):
	if game_manager.score > value:
		game_manager.add_point(value)
		queue_free()
		spawn_manager.num_enemies_spawned -= 1
	else:
		game_manager.set_game_over()

func _process(delta):
	# TODO: 
	#  1. if player in detection range,
	#	  grab location of the player and shoot at them
	#  2. add a timer cool down?
	if randi_range(0, 1):
		shoot()

func shoot():
	var speed: float = 1000
	var max_range: float = 1000
	var p: Projectile = projectile.instantiate()
	#var p: Projectile = Projectile.get_projectile(speed, max_range, 0)
	get_parent().add_child(p)
	p.transform = $ProjectileEmitter.global_transform
