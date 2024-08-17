extends CharacterBody2D

@onready var game_manager = %GameManager

const SPEED: float = 600.0
var mouse_position = null

# Character movement - the player follows the mouse when left click is held
func _physics_process(delta: float) -> void:
	# TODO: Comment this out if you want to maintain velocity after stop clicking
	velocity = Vector2(0,0)
	mouse_position = get_global_mouse_position()
	
	# change the player size based on score
	scale = Vector2((game_manager.score + 900) / 1000, (game_manager.score + 900) / 1000)
	
	if Input.is_action_pressed("move"):
		var direction: Vector2 = (mouse_position - position).normalized()
		velocity = (direction * SPEED)
	
	move_and_slide()


# Moves the player forward a certain amount
func dash() -> void:
	print("dash")


# The player bites on an enemy giving bonus combos
func chomp() -> void:
	pass


# If combo meter is full, it activates a temporary speed boost and invincibility 
func frenzy() -> void:
	pass
