extends Node2D

func _ready():
	AudioPlayer.play_music_level()
	$highscores1.text = str(int(Global.topScores[0]))
	$highscores2.text = str(int(Global.topScores[1]))
	$highscores3.text = str(int(Global.topScores[2]))
	$highscores4.text = str(int(Global.topScores[3]))
	$highscores5.text = str(int(Global.topScores[4]))
