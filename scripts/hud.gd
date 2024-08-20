extends CanvasLayer

@onready var game_manager: Node = %GameManager

@onready var player = %Player
@onready var frenzy_icon = $FrenzyIcon
@onready var frenzyTimer = $FrenzyIcon/Timer
@onready var dashTimer = $DashIcon/Timer
@onready var dash_icon = $DashIcon

@onready var regfish = $Fish1
@onready var tadpole = $Fish2
@onready var pufferfish = $Fish3
@onready var anglerfish = $Fish4

const pufferfish_value: float = 150.0
const anglerfish_value: float = 300.0

var pufferfish_unlocked: bool = false
var anglerfish_unlocked: bool = false

var time = 0

func _ready() -> void:
	frenzyTimer.one_shot = true
	dashTimer.one_shot = true
	pufferfish.hide()
	anglerfish.hide()

func _frenzyCooldown() -> void:
	frenzyTimer.start()

func _dashCooldown() -> void:
	dashTimer.start()

func update_score(value: float) -> void:
	$scoreLabel.text = "SCORE: %d" % value

func _on_frenzy_timer_timeout():
	player.cast_frenzy = true

func _process(delta):
	frenzy_icon.pb.value = 100 - (frenzyTimer.time_left * 10)
	dash_icon.pb.value = 100 - (dashTimer.time_left * 100 / 2)
	time += delta
	$timerLabel.text = "%d" % time
	
	if game_manager.score > 150 and pufferfish_unlocked == false:
		pufferfish_unlocked = true
		pufferfish.show()
		SfxPlayer.play_unlock()
	if game_manager.score > 300 and anglerfish_unlocked == false:
		anglerfish_unlocked = true
		anglerfish.show()
		SfxPlayer.play_unlock()

func _on_dash_timer_timeout():
	player.can_dash = true
