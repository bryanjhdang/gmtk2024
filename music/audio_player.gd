extends Node2D

@onready var bgm = $"8BitBossa"

var played: bool = false

func play_music_level():
	if not played:
		bgm.play()
		played = true
