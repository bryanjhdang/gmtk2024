extends Node

@onready var hud = %Hud


# use score as metric of stage progression (i.e. enemy difficulty)
var score: float
var enemy = preload("res://characters/enemy/enemy_base.tscn")

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

# spawns (1) enemy per timer timeout
func _on_timer_timeout():
	var x = randf_range(20, 1000)
	var y = randf_range(20, 1000)
	var enemy_to_spawn = EnemyBase.new_enemy("", 1.0, 1.0, 100)
	enemy_to_spawn.position = Vector2(x, y)
	add_child(enemy_to_spawn)
	
	
