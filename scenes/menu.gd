extends Node2D

var scoreboard: Array[Label] = [$highscores1, $highscores2, $highscores3, $highscores4, $highscores5]

func _ready():
	$highscores1.text = str(int(Global.topScores[0]))
	$highscores2.text = str(int(Global.topScores[1]))
	$highscores3.text = str(int(Global.topScores[2]))
	$highscores4.text = str(int(Global.topScores[3]))
	$highscores5.text = str(int(Global.topScores[4]))
