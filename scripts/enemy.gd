class_name Enemy
extends Area2D

@onready var game_manager: Node = get_node("../../GameManager")
@onready var spawn_manager: Node2D = get_parent()

const enemy = preload("res://characters/enemy/enemy.tscn")
var value: float = 1
var speed: float = 1
var projectile_type: int = 0

# constructor for a enemy base object, passed in parameters modify the base object
# to construct an upgraded enemy
static func enemy_factory() -> Enemy:
	return enemy.instantiate()

# hanldes scoring mechanics for collided enemies
func _on_body_entered(body):
	if game_manager.score > value:
		game_manager.add_point(value)
		queue_free()
		spawn_manager.num_enemies_spawned -= 1
	else:
		game_manager.set_game_over()
