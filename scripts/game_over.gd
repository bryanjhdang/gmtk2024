extends CanvasLayer
	
@onready var score_label = %scoreLabel

func _ready() -> void:
	score_label.text = "Score: %d" % int(Global.latestScore)
	AudioPlayer.play_music_level()

func _on_yes_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/sandbox.tscn")

func _on_no_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
