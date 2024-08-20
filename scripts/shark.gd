extends "res://scripts/fish.gd"

func _on_fish_body_entered(body: Node2D) -> void:
	game_manager.set_game_over()
