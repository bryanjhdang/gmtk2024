extends CharacterBody2D

@onready var game_manager = %GameManager
@onready var hud = %Hud

# Player
const SPEED: float = 500.0
var acceleration: float = 5000.0
var deceleration: float = 700.0
var health: int = 3

# Dash
var can_dash: bool = true
var is_dashing: bool = false
var dash_direction: Vector2
var dash_speed_multiplier: int = 2

# Movement
const BOUND: float = 2
var mouse_position: Vector2
var prev_direction: Vector2

# Frenzy
const BOOST: float = 600.0
var cast_frenzy: bool = true
var frenzy_enabled: bool = false


# Character movement - the player follows the mouse when left click is held
func _process(delta: float) -> void:
	# change the player size based on score
	scale = Vector2((game_manager.score + 900) / 1000, (game_manager.score + 900) / 1000)
	
	#prevent spinout of sprite model
	var distance: Vector2 = get_global_mouse_position() - position
	if ((pow(distance.x, 2) + pow(distance.y, 2)) > 0):
		_rotate_player()
		
	if not is_dashing:
		if Input.is_action_pressed("move"):
			_apply_acceleration(delta)
		else:
			_apply_deceleration(delta)
		
	# for testing purposes
	if Input.is_action_pressed("suicide"):
		_suicide()

	move_and_slide()
	
	
	# Handle abilities
	if Input.is_action_just_pressed("dash"):
		_dash()
	if Input.is_action_just_pressed("chomp"):
		_chomp()
	if Input.is_action_pressed("frenzy"):
		_frenzy()


func _rotate_player() -> void:
	var mouse_position = get_global_mouse_position()
	var direction = mouse_position - global_position

	# Flip the sprite based on the horizontal direction
	if direction.x < -1:  # Mouse is to the left
		self.scale = Vector2(-1,1)
		rotation = direction.angle() + PI
	elif direction.x > 1:  # Mouse is to the right
		self.scale = Vector2(1,1)
		rotation = direction.angle()

func _apply_dash_movement(delta: float) -> void:
	pass

func _apply_acceleration(delta: float) -> void:
	var direction = _get_mouse_direction()
	
	# Check if the player is trying to move in the opposite direction
	if velocity.dot(direction) < 0:
		if frenzy_enabled:
			velocity -= velocity.normalized() * deceleration * 10 * delta
		else:
			velocity -= velocity.normalized() * deceleration * delta

	velocity += direction * acceleration * delta

	# Clamp the velocity to the maximum speed
	if velocity.length() > SPEED:
		if frenzy_enabled:
			velocity = velocity.normalized() * (SPEED + BOOST)
		else:
			velocity = velocity.normalized() * SPEED

func _apply_deceleration(delta: float) -> void:
	if velocity.length() > 0:
		velocity -= velocity.normalized() * deceleration * delta
	
	# Stop the player when the velocity is very small to avoid infinite sliding
	if velocity.length() < 1:
		velocity = Vector2()


func _get_mouse_direction() -> Vector2:
	mouse_position = get_global_mouse_position()
	return (mouse_position - position).normalized()


func _is_player_stationary() -> bool:
	if abs(mouse_position.x - position.x) < BOUND and abs(mouse_position.y - position.y) < BOUND:
		return false
	return true


func _dash() -> void:
	if can_dash:
		can_dash = false
		is_dashing = true
		dash_direction = _get_mouse_direction()
		velocity = dash_direction * SPEED * dash_speed_multiplier
		
		# Create a timer until dash ends
		var dash_timer: SceneTreeTimer = get_tree().create_timer(0.3)
		dash_timer.timeout.connect(_end_dash)


func _end_dash() -> void:
	is_dashing = false
	can_dash = true
	velocity = dash_direction * SPEED


# The player bites on an enemy giving bonus combos
func _chomp() -> void:
	print("chomp")


# If combo meter is full, it activates a temporary speed boost and invincibility from the fishes 
func _frenzy() -> void:
	if cast_frenzy:
		cast_frenzy = false
		hud._frenzyCooldown()
		frenzy_enabled = true
		set_collision_layer_value(1, false)
		await get_tree().create_timer(3.0).timeout
		frenzy_enabled = false
		set_collision_layer_value(1, true)

# DEBUG: kill yourself NOW.
func _suicide() -> void:
	print("dying")
	_die()


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
	
	game_manager.set_game_over()
	print("died")
