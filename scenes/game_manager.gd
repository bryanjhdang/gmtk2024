extends Node

@onready var hud = %Hud


var score: float

func _ready() -> void:
	score = 5
	hud.update_score(score)
	
func add_point(amount: float) -> void:
	score += amount
	update_score_label()
	print(score)

func update_score_label() -> void:
	if hud:
		hud.update_score(score)
		
func set_game_over() -> void:
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
