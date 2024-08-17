extends Label

var score = 0

func update_score(new_score: float) -> void:
	score = new_score

func _process(delta: float) -> void:
	text = "Score: %d" % score
	pass
