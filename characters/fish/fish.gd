extends Node2D

@onready var game_manager: Node = %GameManager
@export var value: float

# Fish
#const SPEED: float = 500.0
#var acceleration: float = 5000.0
#var deceleration: float = 700.0
#var velocity: float = SPEED / value
#
## Fish movement - the fish moves based on fish value and speed
#func _process(delta: float) -> void:
	#
	#
	#pass
	##if Input.is_action_pressed("move"):
		##_apply_acceleration(delta)
	##else:
		##_apply_deceleration(delta)
#
#
#func _apply_acceleration(delta: float) -> void:
	#pass
	##var direction = _get_mouse_direction()
	#
### Check if the player is trying to move in the opposite direction
	##if velocity.dot(direction) < 0:
		##velocity -= velocity.normalized() * deceleration * delta
##
	##velocity += direction * acceleration * delta
##
	### Clamp the velocity to the maximum speed
	##if velocity.length() > SPEED:
		##velocity = velocity.normalized() * SPEED
##
#func _apply_deceleration(delta: float) -> void:
	#pass
	##if velocity.length() > 0:
		##velocity -= velocity.normalized() * deceleration * delta
##
	### Stop the player when the velocity is very small to avoid infinite sliding
	##if velocity.length() < 1:
		##velocity = Vector2()
##
##
##func _get_mouse_direction() -> Vector2:
	##mouse_position = get_global_mouse_position()
	##return (mouse_position - position).normalized()
#
#



func _on_detection_cone_body_entered(body: Node2D) -> void:
	if game_manager.score > value:
		print("fishie: AHHHHH RUN AWAY")
	else:
		print("the player: AHHHHH RUN AWAY")


func _on_fish_body_entered(body: Node2D) -> void:
	if game_manager.score > value:
		game_manager.add_point(value)
		queue_free()
	else:
		print("lol you died")
		get_tree().paused = true
