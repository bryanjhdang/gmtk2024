extends CharacterBody2D

@onready var game_manager = %GameManager

# Player
var speed: float = 600.0
var acceleration: float = 5000.0
var deceleration: float = 600.0
var health: int = 3

# Movement
const BOUND: float = 2
var mouse_position: Vector2 = Vector2(0,0)
var prev_direction: Vector2

func get_input():
	var input_direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	
	if input_direction != Vector2(0, 0):
		velocity = input_direction * speed
		prev_direction = input_direction
	else:
		velocity = prev_direction * speed

# Character movement - the player follows the mouse when left click is held
func _process(delta: float) -> void:
	# change the player size based on score
	scale = Vector2((game_manager.score + 900) / 1000, (game_manager.score + 900) / 1000)
	
	# Handle movement
	mouse_position = get_global_mouse_position()
	#var mouse_direction = _get_mouse_direction()
	if Input.is_action_pressed("move"):
		_apply_acceleration(delta)
	else:
		_apply_deceleration(delta)
	
	move_and_slide()
	
	
	# Handle abilities
	if Input.is_action_just_pressed("dash"):
		_dash()
	if Input.is_action_just_pressed("chomp"):
		_chomp()


func _apply_acceleration(delta: float) -> void:
	var direction = _get_mouse_direction()
	
	# Check if the player is trying to move in the opposite direction
	if velocity.dot(direction) < 0:
	# Apply more deceleration when turning around
		velocity -= velocity.normalized() * deceleration * delta

	velocity += direction * acceleration * delta

	# Clamp the velocity to the maximum speed
	if velocity.length() > speed:
		velocity = velocity.normalized() * speed

func _apply_deceleration(delta: float) -> void:
	if velocity.length() > 0:
		velocity -= velocity.normalized() * deceleration * delta
	
	# Stop the player when the velocity is very small to avoid infinite sliding
	if velocity.length() < 1:
		velocity = Vector2()


func _get_mouse_direction() -> Vector2:
	return (mouse_position - position).normalized()


func _is_player_stationary() -> bool:
	if abs(mouse_position.x - position.x) < BOUND and abs(mouse_position.y - position.y) < BOUND:
		return false
	return true


# Moves the player forward a certain amount
func _dash() -> void:
	speed *= 3
	# lock direction
	await get_tree().create_timer(0.2).timeout
	# unlock speed and direction
	speed /= 3


# The player bites on an enemy giving bonus combos
func _chomp() -> void:
	print("chomp")


# If combo meter is full, it activates a temporary speed boost and invincibility 
func _frenzy() -> void:
	pass


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
