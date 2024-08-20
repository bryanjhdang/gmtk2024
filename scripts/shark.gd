extends "res://scripts/fish.gd"

func _on_fish_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		game_manager.set_game_over()
