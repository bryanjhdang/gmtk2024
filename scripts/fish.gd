extends Node2D
class_name Fish

@onready var game_manager: Node = %GameManager
@onready var player = %Player
@export var value: float

var speed: float = 150
var x: float
var is_detected: bool = false
@export var is_scared: bool # false: chases player | true: fish runs away
@export var fish_detected_speed: float

var can_shoot: bool = true


func _ready() -> void:
	# Randomizes fish horizontal direction on spawn
	_direction_randomizer()
	
	# Set up the timer for periodic direction changes
	var direction_timer = Timer.new()
	direction_timer.wait_time = randi_range(3,8)
	direction_timer.autostart = true
	direction_timer.one_shot = false
	add_child(direction_timer)
	direction_timer.connect("timeout", Callable(self, "_direction_randomizer"))

## Fishy Engine
func _process(delta: float) -> void:
	if is_detected:
		interact_with_player()
	else:
		var motion = Vector2(x, 0) * speed * (1 - abs(scale.x))
		position += motion * delta		
		
func _direction_randomizer() -> void:
	# Randomizes fish horizontal direction
	x = (randi() & 2) - 1  # Direction: -1 == left, 1 == right
	scale.x = (abs(scale.x) * x)

func _on_fish_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if game_manager.score > value:
			game_manager.add_point(value)
			queue_free()
		else:
			game_manager.set_game_over()

func _on_detection_range_body_entered(body: Node2D) -> void:
	#if game_manager.score < value:
	is_detected = true
	print('im gonna getcha!')

func _on_detection_range_body_exited(body: Node2D) -> void:
	is_detected = false
	print('phew im safe!!')
	
func interact_with_player():
	var direction: Vector2
	#fish_detected_speed = (2 - abs(scale.x))
	if is_scared:
		direction = (position - player.position).normalized()
	else:
		direction = (player.position - position).normalized()
	
	
	if can_shoot:
		_shoot()
		can_shoot = false
		emitter_timeout()
	
	# Changes direction of fish
	x = sign(direction.x)
	scale.x = (abs(scale.x) * x)
	
	# Default speed of fish based off fish's scale 
	# fish_detected_speed = (2 - abs(scale.x))
	
	# Runs from the player
	position += direction * speed * get_process_delta_time() * fish_detected_speed	
	
	
func emitter_timeout():
	var timer = get_tree().create_timer(1.5)
	timer.timeout.connect(set_timer)

func set_timer():
	can_shoot = true

# @override 
func _shoot():
	pass
