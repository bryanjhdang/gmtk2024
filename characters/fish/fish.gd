extends Node2D

@onready var game_manager: Node = %GameManager
@export var value: float

func _on_body_entered(body):
	if game_manager.score > value:
		game_manager.add_point(value)
		queue_free()
	else:
		game_manager.set_game_over()
