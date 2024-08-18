extends CanvasLayer

@onready var frenzyTimer = $frenzyLabel/Timer
@onready var player = %Player

func _ready() -> void:
	frenzyTimer.one_shot = true

func _frenzyCooldown() -> void:
	$frenzyLabel.label_settings.font_color = Color(0.745098, 0.745098, 0.745098, 1)
	frenzyTimer.start()

func update_score(value: float) -> void:
	$scoreLabel.text = "Score: %d" % value

func _on_timer_timeout():
	$frenzyLabel.label_settings.font_color = Color(1, 1, 1, 1)
	player.cast_frenzy = true
