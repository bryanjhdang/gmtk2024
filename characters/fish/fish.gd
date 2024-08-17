extends Node2D

@onready var game_manager = %GameManager
@export var value: int

func _on_body_entered(body):
	if game_manager.score > value:
		game_manager.add_point(value)
		queue_free()
	else:
		print("lol you died")
		get_tree().paused = true
