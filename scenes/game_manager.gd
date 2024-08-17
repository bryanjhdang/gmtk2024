extends Node

var score: float = 100

@onready var score_label = %scoreLabel  # Adjust path as needed


func add_point(amount: float):
	score += amount
	update_score_label()
	print(score)

func update_score_label() -> void:
	if score_label:
		score_label.update_score(score)
