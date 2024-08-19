extends Node2D

@onready var game_manager: Node = %GameManager
@onready var player = %Player
@export var value: float


var speed: float = 150
var x: float
var is_detected: bool = false


func _on_body_entered(body):
	if game_manager.score > value:
		game_manager.add_point(value)
		queue_free()
	else:
		game_manager.set_game_over()


func _ready() -> void:
	# Randomizes fish horizontal direction on spawn
	x = (randi() & 2) - 1  # Direction: -1 == left, 1 == right
	scale.x *= x


## Fishy Engine
func _process(delta: float) -> void:
	if is_detected:
		move_towards_player()
	else:
		var motion = Vector2(x, 0) * speed * (1 - abs(scale.x))
		position += motion * delta
		
		

func _on_fish_body_body_entered(body: Node2D) -> void:
	if game_manager.score > value:
		game_manager.add_point(value)
		queue_free()
	else:
		game_manager.set_game_over()



func _on_detection_range_body_entered(body: Node2D) -> void:
	if game_manager.score < value:
		is_detected = true
		print('im gonna getcha!')

func _on_detection_range_body_exited(body: Node2D) -> void:
	is_detected = false
	print('phew im safe!!')
	
	
func move_towards_player():
	var direction = (player.position - position).normalized()
	
	# Changes direction of fish
	x = sign(direction.x)
	scale.x = abs(scale.x) * x 
	
	# Move towards the player
	position += direction * speed * get_process_delta_time() * (2 - abs(scale.x))
	
