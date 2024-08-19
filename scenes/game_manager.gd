extends Node

@onready var hud = %Hud

var score: float
#var enemy = preload("res://characters/enemy/enemy_base.tscn")

func _ready() -> void:
	score = 100
	hud.update_score(score)
	
func add_point(amount: float) -> void:
	score += amount
	update_score_label()
	print(score)

func update_score_label() -> void:
	if hud:
		hud.update_score(score)

# TODO: separate into own spawn scene
func _on_timer_timeout():
	var x = randf_range(20, 1000)
	var y = randf_range(20, 1000)
	#var enemy_to_spawn = EnemyBase.new_enemy("", 1.0, 1.0, 100)
	#enemy_to_spawn.position = Vector2(x, y)
	#add_child(enemy_to_spawn)
	
func set_game_over() -> void:
	self.addScore(score)
	Global.latestScore = score
	print("latest score: %d" % score)
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")

func addScore(score) -> void:
	var idx = Global.topScores.bsearch_custom(score, descending_bsearch, true)
	Global.topScores.insert(idx, score)
	Global.topScores.pop_back()
	Global.save_data.high_score_1 = Global.topScores[0]
	Global.save_data.high_score_2 = Global.topScores[1]
	Global.save_data.high_score_3 = Global.topScores[2]
	Global.save_data.high_score_4 = Global.topScores[3]
	Global.save_data.high_score_5 = Global.topScores[4]
	Global.save_data.save()
	print(Global.topScores)

func descending_bsearch(a, b) -> bool: 
	if a >= b:
		return true
	return false
