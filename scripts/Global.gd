extends Node

var topScores: Array[float] = []
var latestScore: float = 0
var save_data: SaveData

func _ready():
	save_data = SaveData.load_or_create()
	topScores.append(save_data.high_score_1)
	topScores.append(save_data.high_score_2)
	topScores.append(save_data.high_score_3)
	topScores.append(save_data.high_score_4)
	topScores.append(save_data.high_score_5)
