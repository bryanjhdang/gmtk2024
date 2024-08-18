extends CanvasLayer


#@onready var game_manager = %GameManager
	

	
func _ready() -> void:
	pass
	
	
# I NEED HELP IDK HOW TO LINK SCORES (NEED TO MAKE SCORES A GLOBAL VARIABLE)
#func update_score() -> void:
	#$scoreLabel.text = "Score: %d" % game_manager.score


func _on_yes_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/sandbox.tscn")

func _on_no_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
