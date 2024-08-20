extends CanvasLayer

@onready var player = %Player
@onready var frenzy_icon = $FrenzyIcon
@onready var frenzyTimer = $FrenzyIcon/Timer
@onready var dashTimer = $DashIcon/Timer
@onready var dash_icon = $DashIcon

var time = 0

func _ready() -> void:
	frenzyTimer.one_shot = true
	dashTimer.one_shot = true

func _frenzyCooldown() -> void:
	frenzyTimer.start()

func _dashCooldown() -> void:
	dashTimer.start()

func update_score(value: float) -> void:
	$scoreLabel.text = "Score: %d" % value

func _on_frenzy_timer_timeout():
	player.cast_frenzy = true

func _process(delta):
	frenzy_icon.pb.value = 100 - (frenzyTimer.time_left * 10)
	dash_icon.pb.value = 100 - (dashTimer.time_left * 100 / 3)
	time += delta
	$timerLabel.text = "%d" % time

func _on_dash_timer_timeout():
	player.can_dash = true
