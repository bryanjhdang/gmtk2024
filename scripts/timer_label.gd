extends Label


var time = 0

func _process(delta: float) -> void:
	time += delta
	text = "%d" % time
	pass
