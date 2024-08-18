class_name EnemyBase
extends Area2D

@onready var game_manager: Node = get_parent()

const main_scene = preload("res://characters/enemy/enemy_base.tscn")

var type: String
var size_x: float
var size_y: float
var value: float = 1

# constructor for a enemy base object, passed in parameters modify the base object
# to construct an upgraded enemy
static func new_enemy(type: String, size_x: float, size_y: float, value: float) -> EnemyBase:
	var new_enemy: EnemyBase = main_scene.instantiate()
	new_enemy.type = type
	new_enemy.size_x = size_x
	new_enemy.size_y = size_y
	new_enemy.value = value
	
	# TODO: update the base enemy object based on passed in values above
	
	return new_enemy

func _on_body_entered(body):
	print(value)
	print(game_manager.score)
	if game_manager.score > value:
		game_manager.add_point(value)
	queue_free()
