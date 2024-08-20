extends CanvasLayer

@onready var player = %Player
@onready var frenzy_icon = $FrenzyIcon
@onready var timer = $FrenzyIcon/Timer

var time = 0

func _ready() -> void:
	timer.one_shot = true

func _frenzyCooldown() -> void:
	timer.start()

func update_score(value: float) -> void:
	$scoreLabel.text = "SCORE: %d" % value

func _on_timer_timeout():
	player.cast_frenzy = true

func _process(delta):
	frenzy_icon.pb.value = 100 - (timer.time_left * 10)
	time += delta
	$timerLabel.text = "%d" % time
