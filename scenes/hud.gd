extends CanvasLayer

func _frenzyCooldown(value: bool) -> void:
	$frenzyLabel.visible = value

func update_score(value: float) -> void:
	$scoreLabel.text = "Score: %d" % value
