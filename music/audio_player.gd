extends AudioStreamPlayer

func _play_music(volume = 0.0):
	if stream:
		return
	
	volume_db = volume
	play()


func play_music_level():
	_play_music()
