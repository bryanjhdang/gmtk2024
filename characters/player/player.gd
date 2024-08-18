extends CharacterBody2D

@onready var game_manager = %GameManager
@onready var hud = %Hud

# Player stats
const SPEED: float = 600.0
const BOOST: float = 600.0

var health: int = 3
var mouse_position = null
var BOUND = 2
var cast_frenzy: bool = true
var frenzy_enabled: bool = false

# Character movement - the player follows the mouse when left click is held
func _process(delta: float) -> void:
	mouse_position = get_global_mouse_position()

	# change the player size based on score
	scale = Vector2((game_manager.score + 900) / 1000, (game_manager.score + 900) / 1000)
	
	#if Input.is_action_pressed("move"):
	var direction: Vector2 = (mouse_position - position).normalized()
	if frenzy_enabled:
		velocity = (direction * (SPEED + BOOST))
	else:
		velocity = (direction * (SPEED))
	
	if Input.is_action_pressed("frenzy") and cast_frenzy:
		_frenzy()
	
	if _player_is_not_stationary():
		move_and_slide()


func _player_is_not_stationary() -> bool:
	if abs(mouse_position.x - position.x) < BOUND and abs(mouse_position.y - position.y) < BOUND:
		return false
	return true


# Moves the player forward a certain amount
func _dash() -> void:
	print("dash")


# The player bites on an enemy giving bonus combos
func _chomp() -> void:
	pass


# If combo meter is full, it activates a temporary speed boost and invincibility 
func _frenzy() -> void:
	if cast_frenzy:
		cast_frenzy = false
		hud._frenzyCooldown()
		frenzy_enabled = true
		$CollisionShape2D.disabled = true
		await get_tree().create_timer(3.0).timeout
		frenzy_enabled = false
		$CollisionShape2D.disabled = false

# An enemy should call this function if the player gets hit
func get_hurt(damage: int) -> void:
	health -= damage
	if (health > 0):
		_damaged()
	else:
		_die()


func _damaged() -> void:
	# knockback, temp invincibility
	print("got hit")


func _die() -> void:
	# play death animation, call end game
	print("died")
